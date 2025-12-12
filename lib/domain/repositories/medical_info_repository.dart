import '../../core/models/covid_stats.dart';
import '../../core/models/drug_info.dart';

/// Абстрактный репозиторий для медицинской информации.
/// 
/// Определяет контракт для работы с данными о COVID-19
/// и информацией о лекарственных препаратах.
abstract class MedicalInfoRepository {
  // ==================== COVID-19 ====================

  /// Получает глобальную статистику COVID-19.
  Future<CovidGlobalStats> getGlobalCovidStats();

  /// Получает статистику COVID-19 по стране.
  Future<CovidCountryStats> getCountryCovidStats(String country);

  /// Получает статистику COVID-19 по всем странам.
  Future<List<CovidCountryStats>> getAllCountriesCovidStats({String? sortBy});

  /// Получает исторические данные COVID-19 по стране.
  Future<CovidHistoricalData> getCountryCovidHistorical(
    String country, {
    int lastDays = 30,
  });

  /// Получает глобальные исторические данные COVID-19.
  Future<CovidHistoricalData> getGlobalCovidHistorical({int lastDays = 30});

  // ==================== ЛЕКАРСТВА ====================

  /// Ищет лекарства по названию.
  Future<DrugSearchResult> searchDrugs(
    String query, {
    int limit = 10,
    int skip = 0,
  });

  /// Ищет лекарства по названию бренда.
  Future<DrugSearchResult> searchDrugsByBrand(
    String brandName, {
    int limit = 10,
  });

  /// Ищет лекарства по общему названию.
  Future<DrugSearchResult> searchDrugsByGenericName(
    String genericName, {
    int limit = 10,
  });

  /// Получает информацию о побочных эффектах препарата.
  Future<List<DrugAdverseEvent>> getDrugAdverseEvents(
    String drugName, {
    int limit = 10,
  });
}
