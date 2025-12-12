import 'package:json_annotation/json_annotation.dart';

part 'drug_dto.g.dart';

// ============================================================================
// RxNorm API DTOs (NIH)
// ============================================================================

/// DTO для ответа RxNorm API - поиск по названию.
@JsonSerializable()
class RxNormDrugsResponseDto {
  final RxNormDrugGroupDto? drugGroup;

  const RxNormDrugsResponseDto({this.drugGroup});

  factory RxNormDrugsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormDrugsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormDrugsResponseDtoToJson(this);
}

/// DTO для группы препаратов RxNorm.
@JsonSerializable()
class RxNormDrugGroupDto {
  final String? name;
  final List<RxNormConceptGroupDto>? conceptGroup;

  const RxNormDrugGroupDto({this.name, this.conceptGroup});

  factory RxNormDrugGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormDrugGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormDrugGroupDtoToJson(this);
}

/// DTO для группы концепций RxNorm.
@JsonSerializable()
class RxNormConceptGroupDto {
  final String? tty;
  final List<RxNormConceptPropertiesDto>? conceptProperties;

  const RxNormConceptGroupDto({this.tty, this.conceptProperties});

  factory RxNormConceptGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormConceptGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormConceptGroupDtoToJson(this);
}

/// DTO для свойств концепции RxNorm.
@JsonSerializable()
class RxNormConceptPropertiesDto {
  final String? rxcui;
  final String? name;
  final String? synonym;
  final String? tty;
  final String? language;
  final String? suppress;
  final String? umlscui;

  const RxNormConceptPropertiesDto({
    this.rxcui,
    this.name,
    this.synonym,
    this.tty,
    this.language,
    this.suppress,
    this.umlscui,
  });

  factory RxNormConceptPropertiesDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormConceptPropertiesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormConceptPropertiesDtoToJson(this);
}

/// DTO для ответа свойств препарата RxNorm.
@JsonSerializable()
class RxNormPropertiesResponseDto {
  final RxNormPropertiesDto? properties;

  const RxNormPropertiesResponseDto({this.properties});

  factory RxNormPropertiesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormPropertiesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormPropertiesResponseDtoToJson(this);
}

/// DTO для свойств препарата RxNorm.
@JsonSerializable()
class RxNormPropertiesDto {
  final String? rxcui;
  final String? name;
  final String? synonym;
  final String? tty;
  final String? language;
  final String? suppress;

  const RxNormPropertiesDto({
    this.rxcui,
    this.name,
    this.synonym,
    this.tty,
    this.language,
    this.suppress,
  });

  factory RxNormPropertiesDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormPropertiesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormPropertiesDtoToJson(this);
}

/// DTO для приблизительного поиска RxNorm.
@JsonSerializable()
class RxNormApproximateResponseDto {
  final RxNormApproximateGroupDto? approximateGroup;

  const RxNormApproximateResponseDto({this.approximateGroup});

  factory RxNormApproximateResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormApproximateResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormApproximateResponseDtoToJson(this);
}

/// DTO для группы приблизительного поиска.
@JsonSerializable()
class RxNormApproximateGroupDto {
  final String? inputTerm;
  final List<RxNormCandidateDto>? candidate;

  const RxNormApproximateGroupDto({this.inputTerm, this.candidate});

  factory RxNormApproximateGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormApproximateGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormApproximateGroupDtoToJson(this);
}

/// DTO для кандидата в результатах поиска.
@JsonSerializable()
class RxNormCandidateDto {
  final String? rxcui;
  final String? rxaui;
  final String? score;
  final String? rank;

  const RxNormCandidateDto({
    this.rxcui,
    this.rxaui,
    this.score,
    this.rank,
  });

  factory RxNormCandidateDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormCandidateDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormCandidateDtoToJson(this);
}

/// DTO для взаимодействий препаратов.
@JsonSerializable()
class RxNormInteractionResponseDto {
  final List<RxNormInteractionTypeGroupDto>? interactionTypeGroup;

  const RxNormInteractionResponseDto({this.interactionTypeGroup});

  factory RxNormInteractionResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormInteractionResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormInteractionResponseDtoToJson(this);
}

/// DTO для группы типов взаимодействий.
@JsonSerializable()
class RxNormInteractionTypeGroupDto {
  final String? sourceDisclaimer;
  final String? sourceName;
  final List<RxNormInteractionTypeDto>? interactionType;

  const RxNormInteractionTypeGroupDto({
    this.sourceDisclaimer,
    this.sourceName,
    this.interactionType,
  });

  factory RxNormInteractionTypeGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormInteractionTypeGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormInteractionTypeGroupDtoToJson(this);
}

/// DTO для типа взаимодействия.
@JsonSerializable()
class RxNormInteractionTypeDto {
  final String? comment;
  final List<RxNormInteractionPairDto>? interactionPair;

  const RxNormInteractionTypeDto({this.comment, this.interactionPair});

  factory RxNormInteractionTypeDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormInteractionTypeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormInteractionTypeDtoToJson(this);
}

/// DTO для пары взаимодействующих препаратов.
@JsonSerializable()
class RxNormInteractionPairDto {
  final String? description;
  final String? severity;
  final List<RxNormInteractionConceptDto>? interactionConcept;

  const RxNormInteractionPairDto({
    this.description,
    this.severity,
    this.interactionConcept,
  });

  factory RxNormInteractionPairDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormInteractionPairDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormInteractionPairDtoToJson(this);
}

/// DTO для концепции взаимодействия.
@JsonSerializable()
class RxNormInteractionConceptDto {
  final RxNormMinConceptItemDto? minConceptItem;
  final String? sourceConceptItem;

  const RxNormInteractionConceptDto({
    this.minConceptItem,
    this.sourceConceptItem,
  });

  factory RxNormInteractionConceptDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormInteractionConceptDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormInteractionConceptDtoToJson(this);
}

/// DTO для минимальной информации о концепции.
@JsonSerializable()
class RxNormMinConceptItemDto {
  final String? rxcui;
  final String? name;
  final String? tty;

  const RxNormMinConceptItemDto({this.rxcui, this.name, this.tty});

  factory RxNormMinConceptItemDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormMinConceptItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormMinConceptItemDtoToJson(this);
}

/// DTO для получения RxCUI по имени.
@JsonSerializable()
class RxNormIdResponseDto {
  final RxNormIdGroupDto? idGroup;

  const RxNormIdResponseDto({this.idGroup});

  factory RxNormIdResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormIdResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormIdResponseDtoToJson(this);
}

/// DTO для группы идентификаторов.
@JsonSerializable()
class RxNormIdGroupDto {
  final String? name;
  final List<String>? rxnormId;

  const RxNormIdGroupDto({this.name, this.rxnormId});

  factory RxNormIdGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormIdGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormIdGroupDtoToJson(this);
}

// ============================================================================
// Дополнительные DTO для расширенной информации
// ============================================================================

/// DTO для ответа со всеми связанными концепциями.
@JsonSerializable()
class RxNormAllRelatedResponseDto {
  final RxNormAllRelatedGroupDto? allRelatedGroup;

  const RxNormAllRelatedResponseDto({this.allRelatedGroup});

  factory RxNormAllRelatedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormAllRelatedResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormAllRelatedResponseDtoToJson(this);
}

/// DTO для группы всех связанных концепций.
@JsonSerializable()
class RxNormAllRelatedGroupDto {
  final String? rxcui;
  final String? name;
  final List<RxNormConceptGroupDto>? conceptGroup;

  const RxNormAllRelatedGroupDto({this.rxcui, this.name, this.conceptGroup});

  factory RxNormAllRelatedGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormAllRelatedGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormAllRelatedGroupDtoToJson(this);
}

/// DTO для ответа с классами препарата.
@JsonSerializable()
class RxClassResponseDto {
  final RxClassDataDto? rxclassMinConceptList;

  const RxClassResponseDto({this.rxclassMinConceptList});

  factory RxClassResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxClassResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxClassResponseDtoToJson(this);
}

/// DTO для данных классов.
@JsonSerializable()
class RxClassDataDto {
  final List<RxClassMinConceptDto>? rxclassMinConcept;

  const RxClassDataDto({this.rxclassMinConcept});

  factory RxClassDataDto.fromJson(Map<String, dynamic> json) =>
      _$RxClassDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxClassDataDtoToJson(this);
}

/// DTO для минимальной информации о классе.
@JsonSerializable()
class RxClassMinConceptDto {
  final String? classId;
  final String? className;
  final String? classType;

  const RxClassMinConceptDto({this.classId, this.className, this.classType});

  factory RxClassMinConceptDto.fromJson(Map<String, dynamic> json) =>
      _$RxClassMinConceptDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxClassMinConceptDtoToJson(this);
}

/// DTO для ответа с NDC кодами.
@JsonSerializable()
class RxNormNdcResponseDto {
  final RxNormNdcGroupDto? ndcGroup;

  const RxNormNdcResponseDto({this.ndcGroup});

  factory RxNormNdcResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormNdcResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormNdcResponseDtoToJson(this);
}

/// DTO для группы NDC кодов.
@JsonSerializable()
class RxNormNdcGroupDto {
  final String? rxcui;
  final List<String>? ndcList;

  const RxNormNdcGroupDto({this.rxcui, this.ndcList});

  factory RxNormNdcGroupDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormNdcGroupDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormNdcGroupDtoToJson(this);
}

/// DTO для истории препарата.
@JsonSerializable()
class RxNormHistoryResponseDto {
  final RxNormHistoryDataDto? rxcuiStatusHistory;

  const RxNormHistoryResponseDto({this.rxcuiStatusHistory});

  factory RxNormHistoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormHistoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormHistoryResponseDtoToJson(this);
}

/// DTO для данных истории.
@JsonSerializable()
class RxNormHistoryDataDto {
  final RxNormMetaDataDto? metaData;
  final RxNormAttributesDto? attributes;

  const RxNormHistoryDataDto({this.metaData, this.attributes});

  factory RxNormHistoryDataDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormHistoryDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormHistoryDataDtoToJson(this);
}

/// DTO для метаданных.
@JsonSerializable()
class RxNormMetaDataDto {
  final String? status;
  final String? source;

  const RxNormMetaDataDto({this.status, this.source});

  factory RxNormMetaDataDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormMetaDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormMetaDataDtoToJson(this);
}

/// DTO для атрибутов препарата.
@JsonSerializable()
class RxNormAttributesDto {
  final String? rxcui;
  final String? name;
  final String? tty;
  final String? isMultipleIngredient;
  final String? availableStrength;
  final String? prescribeName;
  final String? doseFormName;
  final String? ingredientAndStrength;

  const RxNormAttributesDto({
    this.rxcui,
    this.name,
    this.tty,
    this.isMultipleIngredient,
    this.availableStrength,
    this.prescribeName,
    this.doseFormName,
    this.ingredientAndStrength,
  });

  factory RxNormAttributesDto.fromJson(Map<String, dynamic> json) =>
      _$RxNormAttributesDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RxNormAttributesDtoToJson(this);
}
