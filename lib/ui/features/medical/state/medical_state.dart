import 'package:mobx/mobx.dart';
import '../../../../core/models/covid_stats.dart';
import '../../../../core/models/drug_info.dart';
import '../../../../domain/usecases/medical/medical_usecases.dart';
import '../../../../data/datasources/remote/network_exceptions.dart';

part 'medical_state.g.dart';

/// MobX Store для управления состоянием медицинской информации.
/// 
/// Управляет данными из сетевых API:
/// - Статистика COVID-19 (Disease.sh API)
/// - Информация о лекарствах (OpenFDA API)
class MedicalState = _MedicalState with _$MedicalState;

abstract class _MedicalState with Store {
  final GetGlobalCovidStatsUseCase _getGlobalCovidStatsUseCase;
  final GetCountryCovidStatsUseCase _getCountryCovidStatsUseCase;
  final GetAllCountriesCovidStatsUseCase _getAllCountriesCovidStatsUseCase;
  final GetCovidHistoricalUseCase _getCovidHistoricalUseCase;
  final SearchDrugsUseCase _searchDrugsUseCase;
  final GetDrugAdverseEventsUseCase _getDrugAdverseEventsUseCase;

  _MedicalState({
    required GetGlobalCovidStatsUseCase getGlobalCovidStatsUseCase,
    required GetCountryCovidStatsUseCase getCountryCovidStatsUseCase,
    required GetAllCountriesCovidStatsUseCase getAllCountriesCovidStatsUseCase,
    required GetCovidHistoricalUseCase getCovidHistoricalUseCase,
    required SearchDrugsUseCase searchDrugsUseCase,
    required GetDrugAdverseEventsUseCase getDrugAdverseEventsUseCase,
  })  : _getGlobalCovidStatsUseCase = getGlobalCovidStatsUseCase,
        _getCountryCovidStatsUseCase = getCountryCovidStatsUseCase,
        _getAllCountriesCovidStatsUseCase = getAllCountriesCovidStatsUseCase,
        _getCovidHistoricalUseCase = getCovidHistoricalUseCase,
        _searchDrugsUseCase = searchDrugsUseCase,
        _getDrugAdverseEventsUseCase = getDrugAdverseEventsUseCase;

  // ==================== COVID-19 STATE ====================

  @observable
  CovidGlobalStats? globalCovidStats;

  @observable
  CovidCountryStats? selectedCountryStats;

  @observable
  ObservableList<CovidCountryStats> countriesStats = ObservableList<CovidCountryStats>();

  @observable
  CovidHistoricalData? covidHistoricalData;

  @observable
  bool isLoadingCovid = false;

  @observable
  String? covidError;

  // ==================== DRUGS STATE ====================

  @observable
  DrugSearchResult? drugSearchResult;

  @observable
  ObservableList<DrugAdverseEvent> adverseEvents = ObservableList<DrugAdverseEvent>();

  @observable
  bool isLoadingDrugs = false;

  @observable
  String? drugError;

  @observable
  String drugSearchQuery = '';

  // ==================== COMPUTED ====================

  @computed
  bool get hasGlobalStats => globalCovidStats != null;

  @computed
  bool get hasCountryStats => selectedCountryStats != null;

  @computed
  bool get hasDrugResults => drugSearchResult != null && drugSearchResult!.drugs.isNotEmpty;

  @computed
  List<DrugInfo> get drugs => drugSearchResult?.drugs ?? [];

  @computed
  int get totalDrugsFound => drugSearchResult?.totalCount ?? 0;

  // ==================== COVID-19 ACTIONS ====================

  /// Загружает глобальную статистику COVID-19.
  @action
  Future<void> loadGlobalCovidStats() async {
    isLoadingCovid = true;
    covidError = null;
    try {
      globalCovidStats = await _getGlobalCovidStatsUseCase.execute();
    } on NetworkException catch (e) {
      covidError = e.message;
    } catch (e) {
      covidError = 'Не удалось загрузить статистику: $e';
    } finally {
      isLoadingCovid = false;
    }
  }

  /// Загружает статистику COVID-19 по стране.
  @action
  Future<void> loadCountryCovidStats(String country) async {
    isLoadingCovid = true;
    covidError = null;
    try {
      selectedCountryStats = await _getCountryCovidStatsUseCase.execute(country);
    } on NetworkException catch (e) {
      covidError = e.message;
    } catch (e) {
      covidError = 'Не удалось загрузить статистику: $e';
    } finally {
      isLoadingCovid = false;
    }
  }

  /// Загружает статистику по всем странам.
  @action
  Future<void> loadAllCountriesStats({String? sortBy}) async {
    isLoadingCovid = true;
    covidError = null;
    try {
      final stats = await _getAllCountriesCovidStatsUseCase.execute(sortBy: sortBy);
      countriesStats.clear();
      countriesStats.addAll(stats);
    } on NetworkException catch (e) {
      covidError = e.message;
    } catch (e) {
      covidError = 'Не удалось загрузить статистику: $e';
    } finally {
      isLoadingCovid = false;
    }
  }

  /// Загружает исторические данные COVID-19.
  @action
  Future<void> loadCovidHistorical({String? country, int lastDays = 30}) async {
    isLoadingCovid = true;
    covidError = null;
    try {
      covidHistoricalData = await _getCovidHistoricalUseCase.execute(
        country: country,
        lastDays: lastDays,
      );
    } on NetworkException catch (e) {
      covidError = e.message;
    } catch (e) {
      covidError = 'Не удалось загрузить данные: $e';
    } finally {
      isLoadingCovid = false;
    }
  }

  // ==================== DRUGS ACTIONS ====================

  /// Ищет лекарства по запросу.
  @action
  Future<void> searchDrugs(String query, {int limit = 10, int skip = 0}) async {
    if (query.trim().isEmpty) {
      drugSearchResult = null;
      return;
    }
    
    drugSearchQuery = query;
    isLoadingDrugs = true;
    drugError = null;
    try {
      drugSearchResult = await _searchDrugsUseCase.execute(
        query,
        limit: limit,
        skip: skip,
      );
    } on NotFoundException {
      // Не найдено результатов - не ошибка
      drugSearchResult = const DrugSearchResult(
        drugs: [],
        totalCount: 0,
      );
    } on NetworkException catch (e) {
      drugError = e.message;
    } catch (e) {
      drugError = 'Не удалось выполнить поиск: $e';
    } finally {
      isLoadingDrugs = false;
    }
  }

  /// Загружает отчёты о побочных эффектах препарата.
  @action
  Future<void> loadAdverseEvents(String drugName, {int limit = 10}) async {
    isLoadingDrugs = true;
    drugError = null;
    try {
      final events = await _getDrugAdverseEventsUseCase.execute(
        drugName,
        limit: limit,
      );
      adverseEvents.clear();
      adverseEvents.addAll(events);
    } on NotFoundException {
      // Не найдено результатов - не ошибка
      adverseEvents.clear();
    } on NetworkException catch (e) {
      drugError = e.message;
    } catch (e) {
      drugError = 'Не удалось загрузить данные: $e';
    } finally {
      isLoadingDrugs = false;
    }
  }

  /// Очищает результаты поиска лекарств.
  @action
  void clearDrugSearch() {
    drugSearchQuery = '';
    drugSearchResult = null;
    drugError = null;
    adverseEvents.clear();
  }

  /// Очищает данные COVID-19.
  @action
  void clearCovidData() {
    globalCovidStats = null;
    selectedCountryStats = null;
    countriesStats.clear();
    covidHistoricalData = null;
    covidError = null;
  }
}
