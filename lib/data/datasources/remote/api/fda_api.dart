import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/fda_dto.dart';

part 'fda_api.g.dart';

/// Retrofit API интерфейс для OpenFDA API.
/// 
/// Предоставляет доступ к данным FDA о лекарственных препаратах:
/// - Поиск по названию (brand name, generic name)
/// - Информация о маркировке (labeling)
/// - NDC коды
@RestApi(baseUrl: 'https://api.fda.gov')
abstract class FdaApi {
  factory FdaApi(Dio dio, {String baseUrl}) = _FdaApi;

  /// Ищет лекарства по названию в базе NDC.
  /// NDC Directory менее защищён и более доступен.
  @GET('/drug/ndc.json')
  Future<FdaNdcResponseDto> searchByNdc({
    @Query('search') required String search,
    @Query('limit') int limit = 20,
  });

  /// Ищет информацию о маркировке (labeling) препаратов.
  @GET('/drug/label.json')
  Future<FdaLabelResponseDto> searchLabels({
    @Query('search') required String search,
    @Query('limit') int limit = 10,
  });

  /// Получает данные Drugs@FDA.
  @GET('/drug/drugsfda.json')
  Future<FdaDrugsResponseDto> searchDrugsFda({
    @Query('search') required String search,
    @Query('limit') int limit = 20,
  });
}
