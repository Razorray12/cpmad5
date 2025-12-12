import '../../core/models/covid_stats.dart';
import '../../core/models/drug_info.dart';
import '../../domain/repositories/medical_info_repository.dart';
import '../datasources/remote/remote_covid_datasource.dart';
import '../datasources/remote/remote_drug_datasource.dart';

/// Реализация репозитория медицинской информации.
/// 
/// Объединяет данные из удалённых источников COVID-19 и лекарств (RxNorm).
class MedicalInfoRepositoryImpl implements MedicalInfoRepository {
  final RemoteCovidDataSource _covidDataSource;
  final RemoteDrugDataSource _drugDataSource;

  MedicalInfoRepositoryImpl(this._covidDataSource, this._drugDataSource);

  // ==================== COVID-19 ====================

  @override
  Future<CovidGlobalStats> getGlobalCovidStats() {
    return _covidDataSource.getGlobalStats();
  }

  @override
  Future<CovidCountryStats> getCountryCovidStats(String country) {
    return _covidDataSource.getCountryStats(country);
  }

  @override
  Future<List<CovidCountryStats>> getAllCountriesCovidStats({String? sortBy}) {
    return _covidDataSource.getAllCountriesStats(sortBy: sortBy);
  }

  @override
  Future<CovidHistoricalData> getCountryCovidHistorical(
    String country, {
    int lastDays = 30,
  }) {
    return _covidDataSource.getCountryHistorical(country, lastDays: lastDays);
  }

  @override
  Future<CovidHistoricalData> getGlobalCovidHistorical({int lastDays = 30}) {
    return _covidDataSource.getGlobalHistorical(lastDays: lastDays);
  }

  // ==================== ЛЕКАРСТВА (RxNorm) ====================

  @override
  Future<DrugSearchResult> searchDrugs(
    String query, {
    int limit = 10,
    int skip = 0,
  }) {
    // RxNorm не поддерживает пагинацию напрямую, используем обычный поиск
    return _drugDataSource.searchDrugs(query);
  }

  @override
  Future<DrugSearchResult> searchDrugsByBrand(
    String brandName, {
    int limit = 10,
  }) {
    // RxNorm использует единый поиск по названию
    return _drugDataSource.searchDrugs(brandName);
  }

  @override
  Future<DrugSearchResult> searchDrugsByGenericName(
    String genericName, {
    int limit = 10,
  }) {
    // RxNorm использует единый поиск по названию
    return _drugDataSource.searchDrugs(genericName);
  }

  @override
  Future<List<DrugAdverseEvent>> getDrugAdverseEvents(
    String drugName, {
    int limit = 10,
  }) async {
    // RxNorm не предоставляет данные о побочных эффектах напрямую
    // Возвращаем пустой список (можно добавить другой источник в будущем)
    return [];
  }

  /// Получает детальную информацию о препарате.
  Future<DrugInfo?> getDrugDetails(String rxcui) {
    return _drugDataSource.getDrugDetails(rxcui);
  }

  /// Получает взаимодействия препарата.
  Future<List<DrugInteraction>> getDrugInteractions(String rxcui) {
    return _drugDataSource.getDrugInteractions(rxcui);
  }
}
