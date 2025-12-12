import '../../../core/models/drug_info.dart';
import 'api/fda_api.dart';
import 'dto/fda_dto.dart';
import 'network_exceptions.dart';
import 'package:dio/dio.dart';

/// Удалённый источник данных для информации о лекарствах из FDA.
/// 
/// Использует OpenFDA API для получения официальной информации FDA:
/// - NDC Directory (National Drug Code)
/// - Drug Labels (маркировка)
/// - Drugs@FDA (одобренные препараты)
class RemoteFdaDataSource {
  final FdaApi _api;

  RemoteFdaDataSource(this._api);

  /// Ищет лекарства по названию в базе NDC.
  Future<DrugSearchResult> searchByNdc(String query) async {
    try {
      // Формируем поисковый запрос для OpenFDA
      final searchQuery = 'brand_name:"$query" OR generic_name:"$query"';
      final dto = await _api.searchByNdc(search: searchQuery, limit: 20);
      return _mapNdcResults(dto);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 400) {
        return const DrugSearchResult(drugs: [], totalCount: 0);
      }
      throw _handleError(e);
    }
  }

  /// Ищет информацию о маркировке препаратов.
  Future<List<FdaLabelInfo>> searchLabels(String query) async {
    try {
      final searchQuery = 'openfda.brand_name:"$query" OR openfda.generic_name:"$query"';
      final dto = await _api.searchLabels(search: searchQuery, limit: 5);
      return _mapLabelResults(dto);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 400) {
        return [];
      }
      throw _handleError(e);
    }
  }

  /// Ищет данные Drugs@FDA.
  Future<DrugSearchResult> searchDrugsFda(String query) async {
    try {
      final searchQuery = 'products.brand_name:"$query" OR openfda.generic_name:"$query"';
      final dto = await _api.searchDrugsFda(search: searchQuery, limit: 20);
      return _mapDrugsFdaResults(dto);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 || e.response?.statusCode == 400) {
        return const DrugSearchResult(drugs: [], totalCount: 0);
      }
      throw _handleError(e);
    }
  }

  /// Получает полную информацию о препарате по ID.
  /// Для NDC формата (xx-xxxx или xxxxx-xxxx) ищет по NDC.
  /// Для Drugs@FDA формата (ANDA/NDA-xxx) ищет по названию.
  Future<FdaDrugDetails?> getDrugDetailsByNdc(String drugId) async {
    // Проверяем, это NDC или Drugs@FDA ID
    final isNdcFormat = RegExp(r'^\d{4,5}-\d{3,4}$').hasMatch(drugId);
    
    if (isNdcFormat) {
      return _getDetailsByNdc(drugId);
    } else {
      // Для Drugs@FDA - ищем label по названию
      return _getDetailsBySearch(drugId);
    }
  }

  Future<FdaDrugDetails?> _getDetailsByNdc(String ndc) async {
    try {
      final dto = await _api.searchByNdc(
        search: 'product_ndc:"$ndc"',
        limit: 1,
      );
      
      if (dto.results == null || dto.results!.isEmpty) {
        return null;
      }

      final result = dto.results!.first;
      
      // Пытаемся получить label - используем только первый ингредиент
      final labelInfo = await _fetchLabelInfo(
        brandName: result.brandName,
        genericName: result.genericName,
        activeIngredients: result.activeIngredients,
      );

      return FdaDrugDetails(
        ndc: result.productNdc ?? ndc,
        brandName: result.brandName,
        genericName: result.genericName,
        dosageForm: result.dosageForm,
        route: result.route?.join(', '),
        labelerName: result.labelerName,
        activeIngredients: result.activeIngredients
            ?.map<String>((i) => '${i.name ?? ""} ${i.strength ?? ""}'.trim())
            .where((String s) => s.isNotEmpty)
            .toList() ?? [],
        pharmClass: result.pharmClass ?? [],
        marketingCategory: result.marketingCategory,
        productType: result.productType,
        labelInfo: labelInfo,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return null;
      }
      throw _handleError(e);
    }
  }

  Future<FdaDrugDetails?> _getDetailsBySearch(String drugId) async {
    // Для Drugs@FDA - ищем label напрямую
    // ID формат: "ANDA076604-001" или "NDA123456-001"
    // Извлекаем application_number для поиска
    final parts = drugId.split('-');
    if (parts.isEmpty) return null;
    
    // Пытаемся найти label по generic_name из поиска
    try {
      final labelInfo = await _fetchLabelByApplicationNumber(parts.first);
      if (labelInfo != null) {
        return FdaDrugDetails(
          ndc: drugId,
          brandName: labelInfo.brandName,
          genericName: labelInfo.genericName,
          labelInfo: labelInfo,
        );
      }
    } catch (_) {
      // Ignore errors
    }
    
    return null;
  }

  /// Получает label info с умным поиском.
  Future<FdaLabelInfo?> _fetchLabelInfo({
    String? brandName,
    String? genericName,
    List<FdaActiveIngredientDto>? activeIngredients,
  }) async {
    // 1. Сначала пробуем по brand_name (если есть и не слишком длинное)
    if (brandName != null && brandName.isNotEmpty && brandName.length < 50) {
      try {
        final labels = await searchLabels(brandName);
        if (labels.isNotEmpty) return labels.first;
      } catch (_) {}
    }
    
    // 2. Затем по первому активному ингредиенту
    if (activeIngredients != null && activeIngredients.isNotEmpty) {
      final firstIngredient = activeIngredients.first.name;
      if (firstIngredient != null && firstIngredient.isNotEmpty) {
        try {
          final labels = await searchLabels(firstIngredient);
          if (labels.isNotEmpty) return labels.first;
        } catch (_) {}
      }
    }
    
    // 3. Наконец, по первому слову generic_name
    if (genericName != null && genericName.isNotEmpty) {
      // Берём только первое слово (первый ингредиент)
      final firstWord = genericName.split(',').first.split(' ').first.trim();
      if (firstWord.isNotEmpty && firstWord.length > 3) {
        try {
          final labels = await searchLabels(firstWord);
          if (labels.isNotEmpty) return labels.first;
        } catch (_) {}
      }
    }
    
    return null;
  }

  /// Ищет label по номеру заявки FDA.
  Future<FdaLabelInfo?> _fetchLabelByApplicationNumber(String appNumber) async {
    try {
      // Форматируем номер заявки для поиска
      final searchQuery = 'openfda.application_number:"$appNumber"';
      final dto = await _api.searchLabels(search: searchQuery, limit: 1);
      final labels = _mapLabelResults(dto);
      return labels.isNotEmpty ? labels.first : null;
    } catch (_) {
      return null;
    }
  }

  DrugSearchResult _mapNdcResults(FdaNdcResponseDto dto) {
    final results = dto.results ?? [];
    final drugs = results.map((r) => DrugInfo(
      id: r.productNdc ?? '',
      brandName: r.brandName ?? r.genericName ?? 'Unknown',
      genericName: r.genericName,
      productType: r.productType,
      doseForm: r.dosageForm,
      route: r.route?.join(', '),
      activeIngredients: r.activeIngredients
          ?.map<String>((i) => '${i.name ?? ""} ${i.strength ?? ""}'.trim())
          .where((String s) => s.isNotEmpty)
          .toList() ?? [],
      therapeuticClasses: r.pharmClass ?? [],
    )).toList();

    return DrugSearchResult(
      drugs: drugs,
      totalCount: dto.meta?.results?.total ?? drugs.length,
    );
  }

  List<FdaLabelInfo> _mapLabelResults(FdaLabelResponseDto dto) {
    final results = dto.results ?? [];
    return results.map((r) => FdaLabelInfo(
      brandName: r.openfda?.brandName?.firstOrNull,
      genericName: r.openfda?.genericName?.firstOrNull,
      manufacturerName: r.openfda?.manufacturerName?.firstOrNull,
      indicationsAndUsage: r.indicationsAndUsage?.join('\n\n'),
      dosageAndAdministration: r.dosageAndAdministration?.join('\n\n'),
      contraindications: r.contraindications?.join('\n\n'),
      warnings: r.warnings?.join('\n\n') ?? r.warningsAndCautions?.join('\n\n'),
      adverseReactions: r.adverseReactions?.join('\n\n'),
      drugInteractions: r.drugInteractions?.join('\n\n'),
      description: r.description?.join('\n\n'),
      mechanismOfAction: r.mechanismOfAction?.join('\n\n'),
      overdosage: r.overdosage?.join('\n\n'),
      howSupplied: r.howSupplied?.join('\n\n'),
      activeIngredients: r.activeIngredient ?? [],
      inactiveIngredients: r.inactiveIngredient ?? [],
      pharmClassEpc: r.openfda?.pharmClassEpc ?? [],
      pharmClassMoa: r.openfda?.pharmClassMoa ?? [],
      rxcui: r.openfda?.rxcui ?? [],
    )).toList();
  }

  DrugSearchResult _mapDrugsFdaResults(FdaDrugsResponseDto dto) {
    final results = dto.results ?? [];
    final drugs = <DrugInfo>[];

    for (final result in results) {
      for (final product in result.products ?? []) {
        drugs.add(DrugInfo(
          id: '${result.applicationNumber ?? ""}-${product.productNumber ?? ""}',
          brandName: product.brandName ?? 'Unknown',
          genericName: result.openfda?.genericName?.firstOrNull,
          productType: result.openfda?.productType?.firstOrNull,
          doseForm: product.dosageForm,
          route: product.route,
          status: product.marketingStatus,
          activeIngredients: product.activeIngredients
              ?.map<String>((i) => '${i.name ?? ""} ${i.strength ?? ""}'.trim())
              .where((String s) => s.isNotEmpty)
              .toList() ?? [],
        ));
      }
    }

    return DrugSearchResult(
      drugs: drugs,
      totalCount: dto.meta?.results?.total ?? drugs.length,
    );
  }

  NetworkException _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = e.response?.data?.toString() ?? e.message ?? 'Unknown error';
    
    if (statusCode == 403) {
      return ForbiddenException('FDA API access denied. WAF/CDN may be blocking the request.');
    }
    if (statusCode == 429) {
      return const NetworkException('Too many requests. Please try again later.');
    }
    
    if (e.error is NetworkException) {
      return e.error as NetworkException;
    }
    return NetworkException(message);
  }
}

/// Информация о маркировке препарата из FDA.
class FdaLabelInfo {
  final String? brandName;
  final String? genericName;
  final String? manufacturerName;
  final String? indicationsAndUsage;
  final String? dosageAndAdministration;
  final String? contraindications;
  final String? warnings;
  final String? adverseReactions;
  final String? drugInteractions;
  final String? description;
  final String? mechanismOfAction;
  final String? overdosage;
  final String? howSupplied;
  final List<String> activeIngredients;
  final List<String> inactiveIngredients;
  final List<String> pharmClassEpc;
  final List<String> pharmClassMoa;
  final List<String> rxcui;

  FdaLabelInfo({
    this.brandName,
    this.genericName,
    this.manufacturerName,
    this.indicationsAndUsage,
    this.dosageAndAdministration,
    this.contraindications,
    this.warnings,
    this.adverseReactions,
    this.drugInteractions,
    this.description,
    this.mechanismOfAction,
    this.overdosage,
    this.howSupplied,
    this.activeIngredients = const [],
    this.inactiveIngredients = const [],
    this.pharmClassEpc = const [],
    this.pharmClassMoa = const [],
    this.rxcui = const [],
  });
}

/// Полная информация о препарате из FDA.
class FdaDrugDetails {
  final String ndc;
  final String? brandName;
  final String? genericName;
  final String? dosageForm;
  final String? route;
  final String? labelerName;
  final List<String> activeIngredients;
  final List<String> pharmClass;
  final String? marketingCategory;
  final String? productType;
  final FdaLabelInfo? labelInfo;

  FdaDrugDetails({
    required this.ndc,
    this.brandName,
    this.genericName,
    this.dosageForm,
    this.route,
    this.labelerName,
    this.activeIngredients = const [],
    this.pharmClass = const [],
    this.marketingCategory,
    this.productType,
    this.labelInfo,
  });
}
