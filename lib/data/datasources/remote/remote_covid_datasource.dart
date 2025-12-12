import '../../../core/models/covid_stats.dart';
import 'api/disease_api.dart';
import 'mappers/covid_mapper.dart';
import 'network_exceptions.dart';
import 'package:dio/dio.dart';

/// Удалённый источник данных для статистики COVID-19.
/// 
/// Использует Disease.sh API для получения актуальной статистики
/// по COVID-19 в разных странах и глобально.
class RemoteCovidDataSource {
  final DiseaseApi _api;

  RemoteCovidDataSource(this._api);

  /// Получает глобальную статистику COVID-19.
  Future<CovidGlobalStats> getGlobalStats() async {
    try {
      final dto = await _api.getGlobalStats();
      return CovidMapper.toGlobalStats(dto);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает статистику по всем странам.
  /// 
  /// [sortBy] - поле для сортировки (cases, deaths, recovered и т.д.)
  Future<List<CovidCountryStats>> getAllCountriesStats({String? sortBy}) async {
    try {
      final dtos = await _api.getAllCountriesStats(sort: sortBy);
      return CovidMapper.toCountryStatsList(dtos);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает статистику по конкретной стране.
  /// 
  /// [country] - название страны или ISO код
  Future<CovidCountryStats> getCountryStats(String country) async {
    try {
      final dto = await _api.getCountryStats(country: country);
      return CovidMapper.toCountryStats(dto);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает статистику по нескольким странам.
  /// 
  /// [countries] - список названий стран
  Future<List<CovidCountryStats>> getMultipleCountriesStats(
    List<String> countries,
  ) async {
    try {
      final countriesStr = countries.join(',');
      final dtos = await _api.getMultipleCountriesStats(countries: countriesStr);
      return CovidMapper.toCountryStatsList(dtos);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает исторические данные по стране.
  /// 
  /// [country] - название страны
  /// [lastDays] - количество дней (по умолчанию 30)
  Future<CovidHistoricalData> getCountryHistorical(
    String country, {
    int lastDays = 30,
  }) async {
    try {
      final dto = await _api.getCountryHistorical(
        country: country,
        lastDays: lastDays,
      );
      return CovidMapper.toHistoricalData(dto, country: country);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Получает глобальные исторические данные.
  /// 
  /// [lastDays] - количество дней (по умолчанию 30)
  Future<CovidHistoricalData> getGlobalHistorical({int lastDays = 30}) async {
    try {
      final dto = await _api.getGlobalHistorical(lastDays: lastDays);
      return CovidMapper.toGlobalHistoricalData(dto);
    } on DioException catch (e) {
      throw _handleError(e);
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
