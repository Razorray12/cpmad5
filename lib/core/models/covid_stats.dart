/// Бизнес-модель глобальной статистики COVID-19.
class CovidGlobalStats {
  final DateTime updatedAt;
  final int totalCases;
  final int todayCases;
  final int totalDeaths;
  final int todayDeaths;
  final int totalRecovered;
  final int todayRecovered;
  final int activeCases;
  final int criticalCases;
  final int totalTests;
  final int affectedCountries;
  final int population;

  const CovidGlobalStats({
    required this.updatedAt,
    required this.totalCases,
    required this.todayCases,
    required this.totalDeaths,
    required this.todayDeaths,
    required this.totalRecovered,
    required this.todayRecovered,
    required this.activeCases,
    required this.criticalCases,
    required this.totalTests,
    required this.affectedCountries,
    required this.population,
  });

  /// Процент смертности.
  double get mortalityRate =>
      totalCases > 0 ? (totalDeaths / totalCases) * 100 : 0;

  /// Процент выздоровления.
  double get recoveryRate =>
      totalCases > 0 ? (totalRecovered / totalCases) * 100 : 0;

  /// Процент активных случаев.
  double get activeRate =>
      totalCases > 0 ? (activeCases / totalCases) * 100 : 0;

  /// Форматированное количество случаев.
  String get formattedCases => _formatNumber(totalCases);

  /// Форматированное количество смертей.
  String get formattedDeaths => _formatNumber(totalDeaths);

  /// Форматированное количество выздоровевших.
  String get formattedRecovered => _formatNumber(totalRecovered);

  String _formatNumber(int number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(2)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}

/// Бизнес-модель статистики COVID-19 по стране.
class CovidCountryStats {
  final String country;
  final String? countryCode;
  final String? flagUrl;
  final DateTime updatedAt;
  final int totalCases;
  final int todayCases;
  final int totalDeaths;
  final int todayDeaths;
  final int totalRecovered;
  final int todayRecovered;
  final int activeCases;
  final int criticalCases;
  final int totalTests;
  final int population;
  final String? continent;

  const CovidCountryStats({
    required this.country,
    this.countryCode,
    this.flagUrl,
    required this.updatedAt,
    required this.totalCases,
    required this.todayCases,
    required this.totalDeaths,
    required this.todayDeaths,
    required this.totalRecovered,
    required this.todayRecovered,
    required this.activeCases,
    required this.criticalCases,
    required this.totalTests,
    required this.population,
    this.continent,
  });

  /// Случаев на миллион населения.
  double get casesPerMillion =>
      population > 0 ? (totalCases / population) * 1000000 : 0;

  /// Смертей на миллион населения.
  double get deathsPerMillion =>
      population > 0 ? (totalDeaths / population) * 1000000 : 0;

  /// Процент смертности.
  double get mortalityRate =>
      totalCases > 0 ? (totalDeaths / totalCases) * 100 : 0;

  /// Процент выздоровления.
  double get recoveryRate =>
      totalCases > 0 ? (totalRecovered / totalCases) * 100 : 0;
}

/// Бизнес-модель исторических данных COVID-19.
class CovidHistoricalData {
  final String? country;
  final List<CovidDailyStats> dailyStats;

  const CovidHistoricalData({
    this.country,
    required this.dailyStats,
  });

  /// Получает статистику за последние N дней.
  List<CovidDailyStats> getLastDays(int days) {
    if (dailyStats.length <= days) return dailyStats;
    return dailyStats.sublist(dailyStats.length - days);
  }

  /// Общий прирост случаев за период.
  int get totalCasesGrowth {
    if (dailyStats.length < 2) return 0;
    return dailyStats.last.cases - dailyStats.first.cases;
  }
}

/// Ежедневная статистика COVID-19.
class CovidDailyStats {
  final DateTime date;
  final int cases;
  final int deaths;
  final int recovered;

  const CovidDailyStats({
    required this.date,
    required this.cases,
    required this.deaths,
    required this.recovered,
  });

  /// Активные случаи.
  int get active => cases - deaths - recovered;
}
