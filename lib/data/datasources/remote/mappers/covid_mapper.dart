import '../../../../core/models/covid_stats.dart';
import '../dto/covid_stats_dto.dart';

/// Маппер для преобразования COVID DTO в бизнес-модели.
class CovidMapper {
  /// Преобразует DTO глобальной статистики в бизнес-модель.
  static CovidGlobalStats toGlobalStats(CovidGlobalStatsDto dto) {
    return CovidGlobalStats(
      updatedAt: DateTime.fromMillisecondsSinceEpoch(dto.updated ?? 0),
      totalCases: dto.cases ?? 0,
      todayCases: dto.todayCases ?? 0,
      totalDeaths: dto.deaths ?? 0,
      todayDeaths: dto.todayDeaths ?? 0,
      totalRecovered: dto.recovered ?? 0,
      todayRecovered: dto.todayRecovered ?? 0,
      activeCases: dto.active ?? 0,
      criticalCases: dto.critical ?? 0,
      totalTests: dto.tests ?? 0,
      affectedCountries: dto.affectedCountries ?? 0,
      population: dto.population ?? 0,
    );
  }

  /// Преобразует DTO статистики по стране в бизнес-модель.
  static CovidCountryStats toCountryStats(CovidCountryStatsDto dto) {
    return CovidCountryStats(
      country: dto.country ?? 'Unknown',
      countryCode: dto.countryInfo?.iso2,
      flagUrl: dto.countryInfo?.flag,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(dto.updated ?? 0),
      totalCases: dto.cases ?? 0,
      todayCases: dto.todayCases ?? 0,
      totalDeaths: dto.deaths ?? 0,
      todayDeaths: dto.todayDeaths ?? 0,
      totalRecovered: dto.recovered ?? 0,
      todayRecovered: dto.todayRecovered ?? 0,
      activeCases: dto.active ?? 0,
      criticalCases: dto.critical ?? 0,
      totalTests: dto.tests ?? 0,
      population: dto.population ?? 0,
      continent: dto.continent,
    );
  }

  /// Преобразует список DTO стран в список бизнес-моделей.
  static List<CovidCountryStats> toCountryStatsList(
    List<CovidCountryStatsDto> dtos,
  ) {
    return dtos.map(toCountryStats).toList();
  }

  /// Преобразует исторические данные в бизнес-модель.
  static CovidHistoricalData toHistoricalData(
    CovidHistoricalDto dto, {
    String? country,
  }) {
    final dailyStats = <CovidDailyStats>[];
    final timeline = dto.timeline;

    if (timeline != null) {
      final cases = timeline.cases ?? {};
      final deaths = timeline.deaths ?? {};
      final recovered = timeline.recovered ?? {};

      for (final entry in cases.entries) {
        final date = _parseDate(entry.key);
        if (date != null) {
          dailyStats.add(CovidDailyStats(
            date: date,
            cases: entry.value,
            deaths: deaths[entry.key] ?? 0,
            recovered: recovered[entry.key] ?? 0,
          ));
        }
      }
    }

    // Сортируем по дате
    dailyStats.sort((a, b) => a.date.compareTo(b.date));

    return CovidHistoricalData(
      country: dto.country ?? country,
      dailyStats: dailyStats,
    );
  }

  /// Преобразует глобальные исторические данные.
  static CovidHistoricalData toGlobalHistoricalData(CovidTimelineDto dto) {
    final dailyStats = <CovidDailyStats>[];
    final cases = dto.cases ?? {};
    final deaths = dto.deaths ?? {};
    final recovered = dto.recovered ?? {};

    for (final entry in cases.entries) {
      final date = _parseDate(entry.key);
      if (date != null) {
        dailyStats.add(CovidDailyStats(
          date: date,
          cases: entry.value,
          deaths: deaths[entry.key] ?? 0,
          recovered: recovered[entry.key] ?? 0,
        ));
      }
    }

    // Сортируем по дате
    dailyStats.sort((a, b) => a.date.compareTo(b.date));

    return CovidHistoricalData(
      country: null,
      dailyStats: dailyStats,
    );
  }

  /// Парсит дату в формате M/D/YY.
  static DateTime? _parseDate(String dateStr) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        final month = int.parse(parts[0]);
        final day = int.parse(parts[1]);
        var year = int.parse(parts[2]);
        // Преобразуем двузначный год в четырёхзначный
        if (year < 100) {
          year += 2000;
        }
        return DateTime(year, month, day);
      }
    } catch (_) {}
    return null;
  }
}
