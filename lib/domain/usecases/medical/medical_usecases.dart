import '../../../core/models/covid_stats.dart';
import '../../../core/models/drug_info.dart';
import '../../repositories/medical_info_repository.dart';

// ==================== COVID-19 USE CASES ====================

/// Use Case для получения глобальной статистики COVID-19.
class GetGlobalCovidStatsUseCase {
  final MedicalInfoRepository _repository;

  GetGlobalCovidStatsUseCase(this._repository);

  /// Выполняет получение глобальной статистики.
  Future<CovidGlobalStats> execute() {
    return _repository.getGlobalCovidStats();
  }
}

/// Use Case для получения статистики COVID-19 по стране.
class GetCountryCovidStatsUseCase {
  final MedicalInfoRepository _repository;

  GetCountryCovidStatsUseCase(this._repository);

  /// Выполняет получение статистики по стране.
  /// 
  /// [country] - название страны или ISO код
  Future<CovidCountryStats> execute(String country) {
    if (country.trim().isEmpty) {
      throw ArgumentError('Название страны не может быть пустым');
    }
    return _repository.getCountryCovidStats(country.trim());
  }
}

/// Use Case для получения статистики COVID-19 по всем странам.
class GetAllCountriesCovidStatsUseCase {
  final MedicalInfoRepository _repository;

  GetAllCountriesCovidStatsUseCase(this._repository);

  /// Выполняет получение статистики по всем странам.
  /// 
  /// [sortBy] - поле для сортировки (cases, deaths, recovered)
  Future<List<CovidCountryStats>> execute({String? sortBy}) {
    return _repository.getAllCountriesCovidStats(sortBy: sortBy);
  }
}

/// Use Case для получения исторических данных COVID-19.
class GetCovidHistoricalUseCase {
  final MedicalInfoRepository _repository;

  GetCovidHistoricalUseCase(this._repository);

  /// Выполняет получение исторических данных.
  /// 
  /// [country] - название страны (null для глобальных данных)
  /// [lastDays] - количество дней
  Future<CovidHistoricalData> execute({
    String? country,
    int lastDays = 30,
  }) {
    if (country != null && country.trim().isNotEmpty) {
      return _repository.getCountryCovidHistorical(
        country.trim(),
        lastDays: lastDays,
      );
    }
    return _repository.getGlobalCovidHistorical(lastDays: lastDays);
  }
}

// ==================== DRUG USE CASES ====================

/// Use Case для поиска лекарств.
class SearchDrugsUseCase {
  final MedicalInfoRepository _repository;

  SearchDrugsUseCase(this._repository);

  /// Выполняет поиск лекарств.
  /// 
  /// [query] - строка поиска
  /// [limit] - максимальное количество результатов
  /// [skip] - смещение для пагинации
  Future<DrugSearchResult> execute(
    String query, {
    int limit = 10,
    int skip = 0,
  }) {
    if (query.trim().isEmpty) {
      throw ArgumentError('Поисковый запрос не может быть пустым');
    }
    return _repository.searchDrugs(query.trim(), limit: limit, skip: skip);
  }
}

/// Use Case для получения информации о побочных эффектах.
class GetDrugAdverseEventsUseCase {
  final MedicalInfoRepository _repository;

  GetDrugAdverseEventsUseCase(this._repository);

  /// Выполняет получение отчётов о побочных эффектах.
  /// 
  /// [drugName] - название препарата
  /// [limit] - максимальное количество отчётов
  Future<List<DrugAdverseEvent>> execute(
    String drugName, {
    int limit = 10,
  }) {
    if (drugName.trim().isEmpty) {
      throw ArgumentError('Название препарата не может быть пустым');
    }
    return _repository.getDrugAdverseEvents(drugName.trim(), limit: limit);
  }
}
