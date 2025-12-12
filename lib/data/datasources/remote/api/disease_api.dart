import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/covid_stats_dto.dart';

part 'disease_api.g.dart';

/// Retrofit API интерфейс для Disease.sh API.
/// 
/// Предоставляет доступ к статистике COVID-19:
/// - Глобальная статистика
/// - Статистика по странам
/// - Исторические данные
@RestApi(baseUrl: 'https://disease.sh/v3/covid-19')
abstract class DiseaseApi {
  factory DiseaseApi(Dio dio, {String baseUrl}) = _DiseaseApi;

  /// Получает глобальную статистику COVID-19.
  /// 
  /// Возвращает общее количество случаев, смертей, выздоровлений
  /// и другую статистику по всему миру.
  @GET('/all')
  Future<CovidGlobalStatsDto> getGlobalStats();

  /// Получает статистику COVID-19 по всем странам.
  /// 
  /// [sort] - поле для сортировки (cases, deaths, recovered и т.д.)
  @GET('/countries')
  Future<List<CovidCountryStatsDto>> getAllCountriesStats({
    @Query('sort') String? sort,
  });

  /// Получает статистику COVID-19 по конкретной стране.
  /// 
  /// [country] - название страны или ISO код (например, "Russia" или "RU")
  @GET('/countries/{country}')
  Future<CovidCountryStatsDto> getCountryStats({
    @Path('country') required String country,
  });

  /// Получает статистику по нескольким странам.
  /// 
  /// [countries] - список стран через запятую (например, "Russia,USA,Germany")
  @GET('/countries/{countries}')
  Future<List<CovidCountryStatsDto>> getMultipleCountriesStats({
    @Path('countries') required String countries,
  });

  /// Получает исторические данные по стране за последние N дней.
  /// 
  /// [country] - название страны
  /// [lastDays] - количество дней (по умолчанию 30)
  @GET('/historical/{country}')
  Future<CovidHistoricalDto> getCountryHistorical({
    @Path('country') required String country,
    @Query('lastdays') int? lastDays,
  });

  /// Получает глобальные исторические данные за последние N дней.
  /// 
  /// [lastDays] - количество дней (по умолчанию 30)
  @GET('/historical/all')
  Future<CovidTimelineDto> getGlobalHistorical({
    @Query('lastdays') int? lastDays,
  });
}
