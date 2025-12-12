import 'package:json_annotation/json_annotation.dart';

part 'covid_stats_dto.g.dart';

/// DTO для глобальной статистики COVID-19 от Disease.sh API.
@JsonSerializable()
class CovidGlobalStatsDto {
  final int? updated;
  final int? cases;
  final int? todayCases;
  final int? deaths;
  final int? todayDeaths;
  final int? recovered;
  final int? todayRecovered;
  final int? active;
  final int? critical;
  final double? casesPerOneMillion;
  final double? deathsPerOneMillion;
  final int? tests;
  final double? testsPerOneMillion;
  final int? population;
  final int? oneCasePerPeople;
  final int? oneDeathPerPeople;
  final int? oneTestPerPeople;
  final int? activePerOneMillion;
  final int? recoveredPerOneMillion;
  final int? criticalPerOneMillion;
  final int? affectedCountries;

  const CovidGlobalStatsDto({
    this.updated,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.population,
    this.oneCasePerPeople,
    this.oneDeathPerPeople,
    this.oneTestPerPeople,
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
    this.affectedCountries,
  });

  factory CovidGlobalStatsDto.fromJson(Map<String, dynamic> json) =>
      _$CovidGlobalStatsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CovidGlobalStatsDtoToJson(this);
}

/// DTO для статистики COVID-19 по стране.
@JsonSerializable()
class CovidCountryStatsDto {
  final int? updated;
  final String? country;
  @JsonKey(name: 'countryInfo')
  final CountryInfoDto? countryInfo;
  final int? cases;
  final int? todayCases;
  final int? deaths;
  final int? todayDeaths;
  final int? recovered;
  final int? todayRecovered;
  final int? active;
  final int? critical;
  final double? casesPerOneMillion;
  final double? deathsPerOneMillion;
  final int? tests;
  final double? testsPerOneMillion;
  final int? population;
  final String? continent;
  final int? oneCasePerPeople;
  final int? oneDeathPerPeople;
  final int? oneTestPerPeople;
  final double? activePerOneMillion;
  final double? recoveredPerOneMillion;
  final double? criticalPerOneMillion;

  const CovidCountryStatsDto({
    this.updated,
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.todayRecovered,
    this.active,
    this.critical,
    this.casesPerOneMillion,
    this.deathsPerOneMillion,
    this.tests,
    this.testsPerOneMillion,
    this.population,
    this.continent,
    this.oneCasePerPeople,
    this.oneDeathPerPeople,
    this.oneTestPerPeople,
    this.activePerOneMillion,
    this.recoveredPerOneMillion,
    this.criticalPerOneMillion,
  });

  factory CovidCountryStatsDto.fromJson(Map<String, dynamic> json) =>
      _$CovidCountryStatsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CovidCountryStatsDtoToJson(this);
}

/// DTO для информации о стране.
@JsonSerializable()
class CountryInfoDto {
  @JsonKey(name: '_id')
  final int? id;
  final String? iso2;
  final String? iso3;
  final double? lat;
  final double? long;
  final String? flag;

  const CountryInfoDto({
    this.id,
    this.iso2,
    this.iso3,
    this.lat,
    this.long,
    this.flag,
  });

  factory CountryInfoDto.fromJson(Map<String, dynamic> json) =>
      _$CountryInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CountryInfoDtoToJson(this);
}

/// DTO для исторических данных COVID-19.
@JsonSerializable()
class CovidHistoricalDto {
  final String? country;
  final List<String>? province;
  final CovidTimelineDto? timeline;

  const CovidHistoricalDto({
    this.country,
    this.province,
    this.timeline,
  });

  factory CovidHistoricalDto.fromJson(Map<String, dynamic> json) =>
      _$CovidHistoricalDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CovidHistoricalDtoToJson(this);
}

/// DTO для временной шкалы COVID-19.
@JsonSerializable()
class CovidTimelineDto {
  final Map<String, int>? cases;
  final Map<String, int>? deaths;
  final Map<String, int>? recovered;

  const CovidTimelineDto({
    this.cases,
    this.deaths,
    this.recovered,
  });

  factory CovidTimelineDto.fromJson(Map<String, dynamic> json) =>
      _$CovidTimelineDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CovidTimelineDtoToJson(this);
}
