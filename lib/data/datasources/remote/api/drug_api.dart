import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/drug_dto.dart';

part 'drug_api.g.dart';

/// Retrofit API интерфейс для RxNorm API (NIH).
/// 
/// Предоставляет доступ к информации о лекарственных препаратах:
/// - Поиск по названию
/// - Информация о препарате
/// - Связанные препараты
/// - Взаимодействия
@RestApi(baseUrl: 'https://rxnav.nlm.nih.gov/REST')
abstract class DrugApi {
  factory DrugApi(Dio dio, {String baseUrl}) = _DrugApi;

  /// Ищет лекарства по названию.
  @GET('/drugs.json')
  Future<RxNormDrugsResponseDto> searchDrugs({
    @Query('name') required String name,
  });

  /// Получает информацию о препарате по RxCUI.
  @GET('/rxcui/{rxcui}/properties.json')
  Future<RxNormPropertiesResponseDto> getDrugProperties({
    @Path('rxcui') required String rxcui,
  });

  /// Получает все связанные концепции препарата.
  /// Возвращает ингредиенты, бренды, формы выпуска и т.д.
  @GET('/rxcui/{rxcui}/allrelated.json')
  Future<RxNormAllRelatedResponseDto> getAllRelated({
    @Path('rxcui') required String rxcui,
  });

  /// Получает информацию о взаимодействиях препарата.
  @GET('/interaction/interaction.json')
  Future<RxNormInteractionResponseDto> getDrugInteractions({
    @Query('rxcui') required String rxcui,
  });

  /// Получает классы препарата (терапевтические, фармакологические).
  @GET('/rxclass/class/byRxcui.json')
  Future<RxClassResponseDto> getDrugClasses({
    @Query('rxcui') required String rxcui,
  });

  /// Получает NDC коды препарата.
  @GET('/rxcui/{rxcui}/ndcs.json')
  Future<RxNormNdcResponseDto> getNdcCodes({
    @Path('rxcui') required String rxcui,
  });

  /// Ищет препарат по точному названию.
  @GET('/rxcui.json')
  Future<RxNormIdResponseDto> getRxcuiByName({
    @Query('name') required String name,
  });

  /// Приблизительный поиск препаратов.
  @GET('/approximateTerm.json')
  Future<RxNormApproximateResponseDto> searchApproximate({
    @Query('term') required String term,
    @Query('maxEntries') int? maxEntries,
  });

  /// Получает историю препарата.
  @GET('/rxcui/{rxcui}/historystatus.json')
  Future<RxNormHistoryResponseDto> getDrugHistory({
    @Path('rxcui') required String rxcui,
  });
}
