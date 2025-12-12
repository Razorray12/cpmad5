// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RxNormDrugsResponseDto _$RxNormDrugsResponseDtoFromJson(
  Map<String, dynamic> json,
) => RxNormDrugsResponseDto(
  drugGroup: json['drugGroup'] == null
      ? null
      : RxNormDrugGroupDto.fromJson(json['drugGroup'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RxNormDrugsResponseDtoToJson(
  RxNormDrugsResponseDto instance,
) => <String, dynamic>{'drugGroup': instance.drugGroup};

RxNormDrugGroupDto _$RxNormDrugGroupDtoFromJson(Map<String, dynamic> json) =>
    RxNormDrugGroupDto(
      name: json['name'] as String?,
      conceptGroup: (json['conceptGroup'] as List<dynamic>?)
          ?.map(
            (e) => RxNormConceptGroupDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$RxNormDrugGroupDtoToJson(RxNormDrugGroupDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'conceptGroup': instance.conceptGroup,
    };

RxNormConceptGroupDto _$RxNormConceptGroupDtoFromJson(
  Map<String, dynamic> json,
) => RxNormConceptGroupDto(
  tty: json['tty'] as String?,
  conceptProperties: (json['conceptProperties'] as List<dynamic>?)
      ?.map(
        (e) => RxNormConceptPropertiesDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$RxNormConceptGroupDtoToJson(
  RxNormConceptGroupDto instance,
) => <String, dynamic>{
  'tty': instance.tty,
  'conceptProperties': instance.conceptProperties,
};

RxNormConceptPropertiesDto _$RxNormConceptPropertiesDtoFromJson(
  Map<String, dynamic> json,
) => RxNormConceptPropertiesDto(
  rxcui: json['rxcui'] as String?,
  name: json['name'] as String?,
  synonym: json['synonym'] as String?,
  tty: json['tty'] as String?,
  language: json['language'] as String?,
  suppress: json['suppress'] as String?,
  umlscui: json['umlscui'] as String?,
);

Map<String, dynamic> _$RxNormConceptPropertiesDtoToJson(
  RxNormConceptPropertiesDto instance,
) => <String, dynamic>{
  'rxcui': instance.rxcui,
  'name': instance.name,
  'synonym': instance.synonym,
  'tty': instance.tty,
  'language': instance.language,
  'suppress': instance.suppress,
  'umlscui': instance.umlscui,
};

RxNormPropertiesResponseDto _$RxNormPropertiesResponseDtoFromJson(
  Map<String, dynamic> json,
) => RxNormPropertiesResponseDto(
  properties: json['properties'] == null
      ? null
      : RxNormPropertiesDto.fromJson(
          json['properties'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RxNormPropertiesResponseDtoToJson(
  RxNormPropertiesResponseDto instance,
) => <String, dynamic>{'properties': instance.properties};

RxNormPropertiesDto _$RxNormPropertiesDtoFromJson(Map<String, dynamic> json) =>
    RxNormPropertiesDto(
      rxcui: json['rxcui'] as String?,
      name: json['name'] as String?,
      synonym: json['synonym'] as String?,
      tty: json['tty'] as String?,
      language: json['language'] as String?,
      suppress: json['suppress'] as String?,
    );

Map<String, dynamic> _$RxNormPropertiesDtoToJson(
  RxNormPropertiesDto instance,
) => <String, dynamic>{
  'rxcui': instance.rxcui,
  'name': instance.name,
  'synonym': instance.synonym,
  'tty': instance.tty,
  'language': instance.language,
  'suppress': instance.suppress,
};

RxNormApproximateResponseDto _$RxNormApproximateResponseDtoFromJson(
  Map<String, dynamic> json,
) => RxNormApproximateResponseDto(
  approximateGroup: json['approximateGroup'] == null
      ? null
      : RxNormApproximateGroupDto.fromJson(
          json['approximateGroup'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RxNormApproximateResponseDtoToJson(
  RxNormApproximateResponseDto instance,
) => <String, dynamic>{'approximateGroup': instance.approximateGroup};

RxNormApproximateGroupDto _$RxNormApproximateGroupDtoFromJson(
  Map<String, dynamic> json,
) => RxNormApproximateGroupDto(
  inputTerm: json['inputTerm'] as String?,
  candidate: (json['candidate'] as List<dynamic>?)
      ?.map((e) => RxNormCandidateDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RxNormApproximateGroupDtoToJson(
  RxNormApproximateGroupDto instance,
) => <String, dynamic>{
  'inputTerm': instance.inputTerm,
  'candidate': instance.candidate,
};

RxNormCandidateDto _$RxNormCandidateDtoFromJson(Map<String, dynamic> json) =>
    RxNormCandidateDto(
      rxcui: json['rxcui'] as String?,
      rxaui: json['rxaui'] as String?,
      score: json['score'] as String?,
      rank: json['rank'] as String?,
    );

Map<String, dynamic> _$RxNormCandidateDtoToJson(RxNormCandidateDto instance) =>
    <String, dynamic>{
      'rxcui': instance.rxcui,
      'rxaui': instance.rxaui,
      'score': instance.score,
      'rank': instance.rank,
    };

RxNormInteractionResponseDto _$RxNormInteractionResponseDtoFromJson(
  Map<String, dynamic> json,
) => RxNormInteractionResponseDto(
  interactionTypeGroup: (json['interactionTypeGroup'] as List<dynamic>?)
      ?.map(
        (e) =>
            RxNormInteractionTypeGroupDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$RxNormInteractionResponseDtoToJson(
  RxNormInteractionResponseDto instance,
) => <String, dynamic>{'interactionTypeGroup': instance.interactionTypeGroup};

RxNormInteractionTypeGroupDto _$RxNormInteractionTypeGroupDtoFromJson(
  Map<String, dynamic> json,
) => RxNormInteractionTypeGroupDto(
  sourceDisclaimer: json['sourceDisclaimer'] as String?,
  sourceName: json['sourceName'] as String?,
  interactionType: (json['interactionType'] as List<dynamic>?)
      ?.map((e) => RxNormInteractionTypeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RxNormInteractionTypeGroupDtoToJson(
  RxNormInteractionTypeGroupDto instance,
) => <String, dynamic>{
  'sourceDisclaimer': instance.sourceDisclaimer,
  'sourceName': instance.sourceName,
  'interactionType': instance.interactionType,
};

RxNormInteractionTypeDto _$RxNormInteractionTypeDtoFromJson(
  Map<String, dynamic> json,
) => RxNormInteractionTypeDto(
  comment: json['comment'] as String?,
  interactionPair: (json['interactionPair'] as List<dynamic>?)
      ?.map((e) => RxNormInteractionPairDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RxNormInteractionTypeDtoToJson(
  RxNormInteractionTypeDto instance,
) => <String, dynamic>{
  'comment': instance.comment,
  'interactionPair': instance.interactionPair,
};

RxNormInteractionPairDto _$RxNormInteractionPairDtoFromJson(
  Map<String, dynamic> json,
) => RxNormInteractionPairDto(
  description: json['description'] as String?,
  severity: json['severity'] as String?,
  interactionConcept: (json['interactionConcept'] as List<dynamic>?)
      ?.map(
        (e) => RxNormInteractionConceptDto.fromJson(e as Map<String, dynamic>),
      )
      .toList(),
);

Map<String, dynamic> _$RxNormInteractionPairDtoToJson(
  RxNormInteractionPairDto instance,
) => <String, dynamic>{
  'description': instance.description,
  'severity': instance.severity,
  'interactionConcept': instance.interactionConcept,
};

RxNormInteractionConceptDto _$RxNormInteractionConceptDtoFromJson(
  Map<String, dynamic> json,
) => RxNormInteractionConceptDto(
  minConceptItem: json['minConceptItem'] == null
      ? null
      : RxNormMinConceptItemDto.fromJson(
          json['minConceptItem'] as Map<String, dynamic>,
        ),
  sourceConceptItem: json['sourceConceptItem'] as String?,
);

Map<String, dynamic> _$RxNormInteractionConceptDtoToJson(
  RxNormInteractionConceptDto instance,
) => <String, dynamic>{
  'minConceptItem': instance.minConceptItem,
  'sourceConceptItem': instance.sourceConceptItem,
};

RxNormMinConceptItemDto _$RxNormMinConceptItemDtoFromJson(
  Map<String, dynamic> json,
) => RxNormMinConceptItemDto(
  rxcui: json['rxcui'] as String?,
  name: json['name'] as String?,
  tty: json['tty'] as String?,
);

Map<String, dynamic> _$RxNormMinConceptItemDtoToJson(
  RxNormMinConceptItemDto instance,
) => <String, dynamic>{
  'rxcui': instance.rxcui,
  'name': instance.name,
  'tty': instance.tty,
};

RxNormIdResponseDto _$RxNormIdResponseDtoFromJson(Map<String, dynamic> json) =>
    RxNormIdResponseDto(
      idGroup: json['idGroup'] == null
          ? null
          : RxNormIdGroupDto.fromJson(json['idGroup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RxNormIdResponseDtoToJson(
  RxNormIdResponseDto instance,
) => <String, dynamic>{'idGroup': instance.idGroup};

RxNormIdGroupDto _$RxNormIdGroupDtoFromJson(Map<String, dynamic> json) =>
    RxNormIdGroupDto(
      name: json['name'] as String?,
      rxnormId: (json['rxnormId'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RxNormIdGroupDtoToJson(RxNormIdGroupDto instance) =>
    <String, dynamic>{'name': instance.name, 'rxnormId': instance.rxnormId};

RxNormAllRelatedResponseDto _$RxNormAllRelatedResponseDtoFromJson(
  Map<String, dynamic> json,
) => RxNormAllRelatedResponseDto(
  allRelatedGroup: json['allRelatedGroup'] == null
      ? null
      : RxNormAllRelatedGroupDto.fromJson(
          json['allRelatedGroup'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RxNormAllRelatedResponseDtoToJson(
  RxNormAllRelatedResponseDto instance,
) => <String, dynamic>{'allRelatedGroup': instance.allRelatedGroup};

RxNormAllRelatedGroupDto _$RxNormAllRelatedGroupDtoFromJson(
  Map<String, dynamic> json,
) => RxNormAllRelatedGroupDto(
  rxcui: json['rxcui'] as String?,
  name: json['name'] as String?,
  conceptGroup: (json['conceptGroup'] as List<dynamic>?)
      ?.map((e) => RxNormConceptGroupDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$RxNormAllRelatedGroupDtoToJson(
  RxNormAllRelatedGroupDto instance,
) => <String, dynamic>{
  'rxcui': instance.rxcui,
  'name': instance.name,
  'conceptGroup': instance.conceptGroup,
};

RxClassResponseDto _$RxClassResponseDtoFromJson(Map<String, dynamic> json) =>
    RxClassResponseDto(
      rxclassMinConceptList: json['rxclassMinConceptList'] == null
          ? null
          : RxClassDataDto.fromJson(
              json['rxclassMinConceptList'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$RxClassResponseDtoToJson(RxClassResponseDto instance) =>
    <String, dynamic>{'rxclassMinConceptList': instance.rxclassMinConceptList};

RxClassDataDto _$RxClassDataDtoFromJson(Map<String, dynamic> json) =>
    RxClassDataDto(
      rxclassMinConcept: (json['rxclassMinConcept'] as List<dynamic>?)
          ?.map((e) => RxClassMinConceptDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RxClassDataDtoToJson(RxClassDataDto instance) =>
    <String, dynamic>{'rxclassMinConcept': instance.rxclassMinConcept};

RxClassMinConceptDto _$RxClassMinConceptDtoFromJson(
  Map<String, dynamic> json,
) => RxClassMinConceptDto(
  classId: json['classId'] as String?,
  className: json['className'] as String?,
  classType: json['classType'] as String?,
);

Map<String, dynamic> _$RxClassMinConceptDtoToJson(
  RxClassMinConceptDto instance,
) => <String, dynamic>{
  'classId': instance.classId,
  'className': instance.className,
  'classType': instance.classType,
};

RxNormNdcResponseDto _$RxNormNdcResponseDtoFromJson(
  Map<String, dynamic> json,
) => RxNormNdcResponseDto(
  ndcGroup: json['ndcGroup'] == null
      ? null
      : RxNormNdcGroupDto.fromJson(json['ndcGroup'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RxNormNdcResponseDtoToJson(
  RxNormNdcResponseDto instance,
) => <String, dynamic>{'ndcGroup': instance.ndcGroup};

RxNormNdcGroupDto _$RxNormNdcGroupDtoFromJson(Map<String, dynamic> json) =>
    RxNormNdcGroupDto(
      rxcui: json['rxcui'] as String?,
      ndcList: (json['ndcList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RxNormNdcGroupDtoToJson(RxNormNdcGroupDto instance) =>
    <String, dynamic>{'rxcui': instance.rxcui, 'ndcList': instance.ndcList};

RxNormHistoryResponseDto _$RxNormHistoryResponseDtoFromJson(
  Map<String, dynamic> json,
) => RxNormHistoryResponseDto(
  rxcuiStatusHistory: json['rxcuiStatusHistory'] == null
      ? null
      : RxNormHistoryDataDto.fromJson(
          json['rxcuiStatusHistory'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RxNormHistoryResponseDtoToJson(
  RxNormHistoryResponseDto instance,
) => <String, dynamic>{'rxcuiStatusHistory': instance.rxcuiStatusHistory};

RxNormHistoryDataDto _$RxNormHistoryDataDtoFromJson(
  Map<String, dynamic> json,
) => RxNormHistoryDataDto(
  metaData: json['metaData'] == null
      ? null
      : RxNormMetaDataDto.fromJson(json['metaData'] as Map<String, dynamic>),
  attributes: json['attributes'] == null
      ? null
      : RxNormAttributesDto.fromJson(
          json['attributes'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$RxNormHistoryDataDtoToJson(
  RxNormHistoryDataDto instance,
) => <String, dynamic>{
  'metaData': instance.metaData,
  'attributes': instance.attributes,
};

RxNormMetaDataDto _$RxNormMetaDataDtoFromJson(Map<String, dynamic> json) =>
    RxNormMetaDataDto(
      status: json['status'] as String?,
      source: json['source'] as String?,
    );

Map<String, dynamic> _$RxNormMetaDataDtoToJson(RxNormMetaDataDto instance) =>
    <String, dynamic>{'status': instance.status, 'source': instance.source};

RxNormAttributesDto _$RxNormAttributesDtoFromJson(Map<String, dynamic> json) =>
    RxNormAttributesDto(
      rxcui: json['rxcui'] as String?,
      name: json['name'] as String?,
      tty: json['tty'] as String?,
      isMultipleIngredient: json['isMultipleIngredient'] as String?,
      availableStrength: json['availableStrength'] as String?,
      prescribeName: json['prescribeName'] as String?,
      doseFormName: json['doseFormName'] as String?,
      ingredientAndStrength: json['ingredientAndStrength'] as String?,
    );

Map<String, dynamic> _$RxNormAttributesDtoToJson(
  RxNormAttributesDto instance,
) => <String, dynamic>{
  'rxcui': instance.rxcui,
  'name': instance.name,
  'tty': instance.tty,
  'isMultipleIngredient': instance.isMultipleIngredient,
  'availableStrength': instance.availableStrength,
  'prescribeName': instance.prescribeName,
  'doseFormName': instance.doseFormName,
  'ingredientAndStrength': instance.ingredientAndStrength,
};
