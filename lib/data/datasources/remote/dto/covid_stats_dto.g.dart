// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'covid_stats_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CovidGlobalStatsDto _$CovidGlobalStatsDtoFromJson(Map<String, dynamic> json) =>
    CovidGlobalStatsDto(
      updated: (json['updated'] as num?)?.toInt(),
      cases: (json['cases'] as num?)?.toInt(),
      todayCases: (json['todayCases'] as num?)?.toInt(),
      deaths: (json['deaths'] as num?)?.toInt(),
      todayDeaths: (json['todayDeaths'] as num?)?.toInt(),
      recovered: (json['recovered'] as num?)?.toInt(),
      todayRecovered: (json['todayRecovered'] as num?)?.toInt(),
      active: (json['active'] as num?)?.toInt(),
      critical: (json['critical'] as num?)?.toInt(),
      casesPerOneMillion: (json['casesPerOneMillion'] as num?)?.toDouble(),
      deathsPerOneMillion: (json['deathsPerOneMillion'] as num?)?.toDouble(),
      tests: (json['tests'] as num?)?.toInt(),
      testsPerOneMillion: (json['testsPerOneMillion'] as num?)?.toDouble(),
      population: (json['population'] as num?)?.toInt(),
      oneCasePerPeople: (json['oneCasePerPeople'] as num?)?.toInt(),
      oneDeathPerPeople: (json['oneDeathPerPeople'] as num?)?.toInt(),
      oneTestPerPeople: (json['oneTestPerPeople'] as num?)?.toInt(),
      activePerOneMillion: (json['activePerOneMillion'] as num?)?.toInt(),
      recoveredPerOneMillion: (json['recoveredPerOneMillion'] as num?)?.toInt(),
      criticalPerOneMillion: (json['criticalPerOneMillion'] as num?)?.toInt(),
      affectedCountries: (json['affectedCountries'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CovidGlobalStatsDtoToJson(
  CovidGlobalStatsDto instance,
) => <String, dynamic>{
  'updated': instance.updated,
  'cases': instance.cases,
  'todayCases': instance.todayCases,
  'deaths': instance.deaths,
  'todayDeaths': instance.todayDeaths,
  'recovered': instance.recovered,
  'todayRecovered': instance.todayRecovered,
  'active': instance.active,
  'critical': instance.critical,
  'casesPerOneMillion': instance.casesPerOneMillion,
  'deathsPerOneMillion': instance.deathsPerOneMillion,
  'tests': instance.tests,
  'testsPerOneMillion': instance.testsPerOneMillion,
  'population': instance.population,
  'oneCasePerPeople': instance.oneCasePerPeople,
  'oneDeathPerPeople': instance.oneDeathPerPeople,
  'oneTestPerPeople': instance.oneTestPerPeople,
  'activePerOneMillion': instance.activePerOneMillion,
  'recoveredPerOneMillion': instance.recoveredPerOneMillion,
  'criticalPerOneMillion': instance.criticalPerOneMillion,
  'affectedCountries': instance.affectedCountries,
};

CovidCountryStatsDto _$CovidCountryStatsDtoFromJson(
  Map<String, dynamic> json,
) => CovidCountryStatsDto(
  updated: (json['updated'] as num?)?.toInt(),
  country: json['country'] as String?,
  countryInfo: json['countryInfo'] == null
      ? null
      : CountryInfoDto.fromJson(json['countryInfo'] as Map<String, dynamic>),
  cases: (json['cases'] as num?)?.toInt(),
  todayCases: (json['todayCases'] as num?)?.toInt(),
  deaths: (json['deaths'] as num?)?.toInt(),
  todayDeaths: (json['todayDeaths'] as num?)?.toInt(),
  recovered: (json['recovered'] as num?)?.toInt(),
  todayRecovered: (json['todayRecovered'] as num?)?.toInt(),
  active: (json['active'] as num?)?.toInt(),
  critical: (json['critical'] as num?)?.toInt(),
  casesPerOneMillion: (json['casesPerOneMillion'] as num?)?.toDouble(),
  deathsPerOneMillion: (json['deathsPerOneMillion'] as num?)?.toDouble(),
  tests: (json['tests'] as num?)?.toInt(),
  testsPerOneMillion: (json['testsPerOneMillion'] as num?)?.toDouble(),
  population: (json['population'] as num?)?.toInt(),
  continent: json['continent'] as String?,
  oneCasePerPeople: (json['oneCasePerPeople'] as num?)?.toInt(),
  oneDeathPerPeople: (json['oneDeathPerPeople'] as num?)?.toInt(),
  oneTestPerPeople: (json['oneTestPerPeople'] as num?)?.toInt(),
  activePerOneMillion: (json['activePerOneMillion'] as num?)?.toDouble(),
  recoveredPerOneMillion: (json['recoveredPerOneMillion'] as num?)?.toDouble(),
  criticalPerOneMillion: (json['criticalPerOneMillion'] as num?)?.toDouble(),
);

Map<String, dynamic> _$CovidCountryStatsDtoToJson(
  CovidCountryStatsDto instance,
) => <String, dynamic>{
  'updated': instance.updated,
  'country': instance.country,
  'countryInfo': instance.countryInfo,
  'cases': instance.cases,
  'todayCases': instance.todayCases,
  'deaths': instance.deaths,
  'todayDeaths': instance.todayDeaths,
  'recovered': instance.recovered,
  'todayRecovered': instance.todayRecovered,
  'active': instance.active,
  'critical': instance.critical,
  'casesPerOneMillion': instance.casesPerOneMillion,
  'deathsPerOneMillion': instance.deathsPerOneMillion,
  'tests': instance.tests,
  'testsPerOneMillion': instance.testsPerOneMillion,
  'population': instance.population,
  'continent': instance.continent,
  'oneCasePerPeople': instance.oneCasePerPeople,
  'oneDeathPerPeople': instance.oneDeathPerPeople,
  'oneTestPerPeople': instance.oneTestPerPeople,
  'activePerOneMillion': instance.activePerOneMillion,
  'recoveredPerOneMillion': instance.recoveredPerOneMillion,
  'criticalPerOneMillion': instance.criticalPerOneMillion,
};

CountryInfoDto _$CountryInfoDtoFromJson(Map<String, dynamic> json) =>
    CountryInfoDto(
      id: (json['_id'] as num?)?.toInt(),
      iso2: json['iso2'] as String?,
      iso3: json['iso3'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      long: (json['long'] as num?)?.toDouble(),
      flag: json['flag'] as String?,
    );

Map<String, dynamic> _$CountryInfoDtoToJson(CountryInfoDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'iso2': instance.iso2,
      'iso3': instance.iso3,
      'lat': instance.lat,
      'long': instance.long,
      'flag': instance.flag,
    };

CovidHistoricalDto _$CovidHistoricalDtoFromJson(Map<String, dynamic> json) =>
    CovidHistoricalDto(
      country: json['country'] as String?,
      province: (json['province'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      timeline: json['timeline'] == null
          ? null
          : CovidTimelineDto.fromJson(json['timeline'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CovidHistoricalDtoToJson(CovidHistoricalDto instance) =>
    <String, dynamic>{
      'country': instance.country,
      'province': instance.province,
      'timeline': instance.timeline,
    };

CovidTimelineDto _$CovidTimelineDtoFromJson(Map<String, dynamic> json) =>
    CovidTimelineDto(
      cases: (json['cases'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      deaths: (json['deaths'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
      recovered: (json['recovered'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toInt()),
      ),
    );

Map<String, dynamic> _$CovidTimelineDtoToJson(CovidTimelineDto instance) =>
    <String, dynamic>{
      'cases': instance.cases,
      'deaths': instance.deaths,
      'recovered': instance.recovered,
    };
