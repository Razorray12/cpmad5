// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MedicalState on _MedicalState, Store {
  Computed<bool>? _$hasGlobalStatsComputed;

  @override
  bool get hasGlobalStats => (_$hasGlobalStatsComputed ??= Computed<bool>(
    () => super.hasGlobalStats,
    name: '_MedicalState.hasGlobalStats',
  )).value;
  Computed<bool>? _$hasCountryStatsComputed;

  @override
  bool get hasCountryStats => (_$hasCountryStatsComputed ??= Computed<bool>(
    () => super.hasCountryStats,
    name: '_MedicalState.hasCountryStats',
  )).value;
  Computed<bool>? _$hasDrugResultsComputed;

  @override
  bool get hasDrugResults => (_$hasDrugResultsComputed ??= Computed<bool>(
    () => super.hasDrugResults,
    name: '_MedicalState.hasDrugResults',
  )).value;
  Computed<List<DrugInfo>>? _$drugsComputed;

  @override
  List<DrugInfo> get drugs => (_$drugsComputed ??= Computed<List<DrugInfo>>(
    () => super.drugs,
    name: '_MedicalState.drugs',
  )).value;
  Computed<int>? _$totalDrugsFoundComputed;

  @override
  int get totalDrugsFound => (_$totalDrugsFoundComputed ??= Computed<int>(
    () => super.totalDrugsFound,
    name: '_MedicalState.totalDrugsFound',
  )).value;

  late final _$globalCovidStatsAtom = Atom(
    name: '_MedicalState.globalCovidStats',
    context: context,
  );

  @override
  CovidGlobalStats? get globalCovidStats {
    _$globalCovidStatsAtom.reportRead();
    return super.globalCovidStats;
  }

  @override
  set globalCovidStats(CovidGlobalStats? value) {
    _$globalCovidStatsAtom.reportWrite(value, super.globalCovidStats, () {
      super.globalCovidStats = value;
    });
  }

  late final _$selectedCountryStatsAtom = Atom(
    name: '_MedicalState.selectedCountryStats',
    context: context,
  );

  @override
  CovidCountryStats? get selectedCountryStats {
    _$selectedCountryStatsAtom.reportRead();
    return super.selectedCountryStats;
  }

  @override
  set selectedCountryStats(CovidCountryStats? value) {
    _$selectedCountryStatsAtom.reportWrite(
      value,
      super.selectedCountryStats,
      () {
        super.selectedCountryStats = value;
      },
    );
  }

  late final _$countriesStatsAtom = Atom(
    name: '_MedicalState.countriesStats',
    context: context,
  );

  @override
  ObservableList<CovidCountryStats> get countriesStats {
    _$countriesStatsAtom.reportRead();
    return super.countriesStats;
  }

  @override
  set countriesStats(ObservableList<CovidCountryStats> value) {
    _$countriesStatsAtom.reportWrite(value, super.countriesStats, () {
      super.countriesStats = value;
    });
  }

  late final _$covidHistoricalDataAtom = Atom(
    name: '_MedicalState.covidHistoricalData',
    context: context,
  );

  @override
  CovidHistoricalData? get covidHistoricalData {
    _$covidHistoricalDataAtom.reportRead();
    return super.covidHistoricalData;
  }

  @override
  set covidHistoricalData(CovidHistoricalData? value) {
    _$covidHistoricalDataAtom.reportWrite(value, super.covidHistoricalData, () {
      super.covidHistoricalData = value;
    });
  }

  late final _$isLoadingCovidAtom = Atom(
    name: '_MedicalState.isLoadingCovid',
    context: context,
  );

  @override
  bool get isLoadingCovid {
    _$isLoadingCovidAtom.reportRead();
    return super.isLoadingCovid;
  }

  @override
  set isLoadingCovid(bool value) {
    _$isLoadingCovidAtom.reportWrite(value, super.isLoadingCovid, () {
      super.isLoadingCovid = value;
    });
  }

  late final _$covidErrorAtom = Atom(
    name: '_MedicalState.covidError',
    context: context,
  );

  @override
  String? get covidError {
    _$covidErrorAtom.reportRead();
    return super.covidError;
  }

  @override
  set covidError(String? value) {
    _$covidErrorAtom.reportWrite(value, super.covidError, () {
      super.covidError = value;
    });
  }

  late final _$drugSearchResultAtom = Atom(
    name: '_MedicalState.drugSearchResult',
    context: context,
  );

  @override
  DrugSearchResult? get drugSearchResult {
    _$drugSearchResultAtom.reportRead();
    return super.drugSearchResult;
  }

  @override
  set drugSearchResult(DrugSearchResult? value) {
    _$drugSearchResultAtom.reportWrite(value, super.drugSearchResult, () {
      super.drugSearchResult = value;
    });
  }

  late final _$adverseEventsAtom = Atom(
    name: '_MedicalState.adverseEvents',
    context: context,
  );

  @override
  ObservableList<DrugAdverseEvent> get adverseEvents {
    _$adverseEventsAtom.reportRead();
    return super.adverseEvents;
  }

  @override
  set adverseEvents(ObservableList<DrugAdverseEvent> value) {
    _$adverseEventsAtom.reportWrite(value, super.adverseEvents, () {
      super.adverseEvents = value;
    });
  }

  late final _$isLoadingDrugsAtom = Atom(
    name: '_MedicalState.isLoadingDrugs',
    context: context,
  );

  @override
  bool get isLoadingDrugs {
    _$isLoadingDrugsAtom.reportRead();
    return super.isLoadingDrugs;
  }

  @override
  set isLoadingDrugs(bool value) {
    _$isLoadingDrugsAtom.reportWrite(value, super.isLoadingDrugs, () {
      super.isLoadingDrugs = value;
    });
  }

  late final _$drugErrorAtom = Atom(
    name: '_MedicalState.drugError',
    context: context,
  );

  @override
  String? get drugError {
    _$drugErrorAtom.reportRead();
    return super.drugError;
  }

  @override
  set drugError(String? value) {
    _$drugErrorAtom.reportWrite(value, super.drugError, () {
      super.drugError = value;
    });
  }

  late final _$drugSearchQueryAtom = Atom(
    name: '_MedicalState.drugSearchQuery',
    context: context,
  );

  @override
  String get drugSearchQuery {
    _$drugSearchQueryAtom.reportRead();
    return super.drugSearchQuery;
  }

  @override
  set drugSearchQuery(String value) {
    _$drugSearchQueryAtom.reportWrite(value, super.drugSearchQuery, () {
      super.drugSearchQuery = value;
    });
  }

  late final _$loadGlobalCovidStatsAsyncAction = AsyncAction(
    '_MedicalState.loadGlobalCovidStats',
    context: context,
  );

  @override
  Future<void> loadGlobalCovidStats() {
    return _$loadGlobalCovidStatsAsyncAction.run(
      () => super.loadGlobalCovidStats(),
    );
  }

  late final _$loadCountryCovidStatsAsyncAction = AsyncAction(
    '_MedicalState.loadCountryCovidStats',
    context: context,
  );

  @override
  Future<void> loadCountryCovidStats(String country) {
    return _$loadCountryCovidStatsAsyncAction.run(
      () => super.loadCountryCovidStats(country),
    );
  }

  late final _$loadAllCountriesStatsAsyncAction = AsyncAction(
    '_MedicalState.loadAllCountriesStats',
    context: context,
  );

  @override
  Future<void> loadAllCountriesStats({String? sortBy}) {
    return _$loadAllCountriesStatsAsyncAction.run(
      () => super.loadAllCountriesStats(sortBy: sortBy),
    );
  }

  late final _$loadCovidHistoricalAsyncAction = AsyncAction(
    '_MedicalState.loadCovidHistorical',
    context: context,
  );

  @override
  Future<void> loadCovidHistorical({String? country, int lastDays = 30}) {
    return _$loadCovidHistoricalAsyncAction.run(
      () => super.loadCovidHistorical(country: country, lastDays: lastDays),
    );
  }

  late final _$searchDrugsAsyncAction = AsyncAction(
    '_MedicalState.searchDrugs',
    context: context,
  );

  @override
  Future<void> searchDrugs(String query, {int limit = 10, int skip = 0}) {
    return _$searchDrugsAsyncAction.run(
      () => super.searchDrugs(query, limit: limit, skip: skip),
    );
  }

  late final _$loadAdverseEventsAsyncAction = AsyncAction(
    '_MedicalState.loadAdverseEvents',
    context: context,
  );

  @override
  Future<void> loadAdverseEvents(String drugName, {int limit = 10}) {
    return _$loadAdverseEventsAsyncAction.run(
      () => super.loadAdverseEvents(drugName, limit: limit),
    );
  }

  late final _$_MedicalStateActionController = ActionController(
    name: '_MedicalState',
    context: context,
  );

  @override
  void clearDrugSearch() {
    final _$actionInfo = _$_MedicalStateActionController.startAction(
      name: '_MedicalState.clearDrugSearch',
    );
    try {
      return super.clearDrugSearch();
    } finally {
      _$_MedicalStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearCovidData() {
    final _$actionInfo = _$_MedicalStateActionController.startAction(
      name: '_MedicalState.clearCovidData',
    );
    try {
      return super.clearCovidData();
    } finally {
      _$_MedicalStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
globalCovidStats: ${globalCovidStats},
selectedCountryStats: ${selectedCountryStats},
countriesStats: ${countriesStats},
covidHistoricalData: ${covidHistoricalData},
isLoadingCovid: ${isLoadingCovid},
covidError: ${covidError},
drugSearchResult: ${drugSearchResult},
adverseEvents: ${adverseEvents},
isLoadingDrugs: ${isLoadingDrugs},
drugError: ${drugError},
drugSearchQuery: ${drugSearchQuery},
hasGlobalStats: ${hasGlobalStats},
hasCountryStats: ${hasCountryStats},
hasDrugResults: ${hasDrugResults},
drugs: ${drugs},
totalDrugsFound: ${totalDrugsFound}
    ''';
  }
}
