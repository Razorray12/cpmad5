import '../../../core/models/drug_info.dart';
import 'api/drug_api.dart';
import 'dto/drug_dto.dart';
import 'mappers/drug_mapper.dart';
import 'network_exceptions.dart';
import 'package:dio/dio.dart';

/// Удалённый источник данных для информации о лекарствах.
/// 
/// Использует RxNorm API (NIH) для получения информации о лекарственных
/// препаратах, включая названия, классы, взаимодействия и связанные препараты.
class RemoteDrugDataSource {
  final DrugApi _api;

  RemoteDrugDataSource(this._api);

  /// Ищет лекарства по названию.
  Future<DrugSearchResult> searchDrugs(String query) async {
    try {
      final dto = await _api.searchDrugs(name: query.trim());
      return DrugMapper.toSearchResult(dto);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const DrugSearchResult(drugs: [], totalCount: 0);
      }
      throw _handleError(e);
    }
  }

  /// Получает детальную информацию о препарате.
  /// Объединяет данные из нескольких источников.
  Future<DrugInfo> getDrugDetails(String rxcui) async {
    try {
      // Базовые свойства
      final propsDto = await _api.getDrugProperties(rxcui: rxcui);
      if (propsDto.properties == null) {
        throw const NotFoundException('Препарат не найден');
      }
      
      var drug = DrugMapper.propertiesToDrugInfo(propsDto.properties!);

      // Параллельно загружаем дополнительную информацию
      final results = await Future.wait([
        _safeCall(() => _api.getAllRelated(rxcui: rxcui)),
        _safeCall(() => _api.getDrugClasses(rxcui: rxcui)),
        _safeCall(() => _api.getDrugInteractions(rxcui: rxcui)),
        _safeCall(() => _api.getDrugHistory(rxcui: rxcui)),
      ]);

      // Обогащаем данными о связанных концепциях
      if (results[0] != null) {
        drug = DrugMapper.enrichWithRelated(
          drug, 
          results[0] as RxNormAllRelatedResponseDto,
        );
      }

      // Обогащаем данными о классах
      if (results[1] != null) {
        drug = DrugMapper.enrichWithClasses(
          drug, 
          results[1] as RxClassResponseDto,
        );
      }

      // Обогащаем данными о взаимодействиях
      if (results[2] != null) {
        drug = DrugMapper.enrichWithInteractions(
          drug, 
          results[2] as RxNormInteractionResponseDto,
        );
      }

      // Обогащаем данными из истории
      if (results[3] != null) {
        drug = DrugMapper.enrichWithHistory(
          drug, 
          results[3] as RxNormHistoryResponseDto,
        );
      }

      return drug;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает взаимодействия препарата.
  Future<List<DrugInteraction>> getDrugInteractions(String rxcui) async {
    try {
      final dto = await _api.getDrugInteractions(rxcui: rxcui);
      return DrugMapper.interactionsToModels(dto);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      throw _handleError(e);
    }
  }

  /// Получает классы препарата.
  Future<List<String>> getDrugClasses(String rxcui) async {
    try {
      final dto = await _api.getDrugClasses(rxcui: rxcui);
      final concepts = dto.rxclassMinConceptList?.rxclassMinConcept ?? [];
      return concepts
          .where((c) => c.className != null)
          .map((c) => c.className!)
          .toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return [];
      }
      throw _handleError(e);
    }
  }

  /// Получает связанные препараты (бренды, ингредиенты).
  Future<Map<String, List<String>>> getRelatedDrugs(String rxcui) async {
    try {
      final dto = await _api.getAllRelated(rxcui: rxcui);
      final groups = dto.allRelatedGroup?.conceptGroup ?? [];
      
      final result = <String, List<String>>{};
      
      for (final group in groups) {
        final tty = group.tty ?? 'OTHER';
        final names = (group.conceptProperties ?? [])
            .where((c) => c.name != null)
            .map((c) => c.name!)
            .toList();
        
        if (names.isNotEmpty) {
          result[tty] = names;
        }
      }
      
      return result;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return {};
      }
      throw _handleError(e);
    }
  }

  /// Безопасный вызов API (возвращает null при ошибке).
  Future<T?> _safeCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (_) {
      return null;
    }
  }

  /// Обрабатывает ошибки Dio.
  NetworkException _handleError(DioException e) {
    if (e.error is NetworkException) {
      return e.error as NetworkException;
    }
    return NetworkException(e.message ?? 'Неизвестная ошибка');
  }
}
