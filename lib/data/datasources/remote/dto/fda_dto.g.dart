// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fda_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FdaNdcResponseDto _$FdaNdcResponseDtoFromJson(Map<String, dynamic> json) =>
    FdaNdcResponseDto(
      meta: json['meta'] == null
          ? null
          : FdaMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => FdaNdcResultDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FdaNdcResultDto _$FdaNdcResultDtoFromJson(
  Map<String, dynamic> json,
) => FdaNdcResultDto(
  productNdc: json['product_ndc'] as String?,
  genericName: json['generic_name'] as String?,
  brandName: json['brand_name'] as String?,
  brandNameBase: json['brand_name_base'] as String?,
  labelerName: json['labeler_name'] as String?,
  dosageForm: json['dosage_form'] as String?,
  route: (json['route'] as List<dynamic>?)?.map((e) => e as String).toList(),
  marketingCategory: json['marketing_category'] as String?,
  marketingStartDate: json['marketing_start_date'] as String?,
  productType: json['product_type'] as String?,
  activeIngredients: (json['active_ingredients'] as List<dynamic>?)
      ?.map((e) => FdaActiveIngredientDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  packaging: (json['packaging'] as List<dynamic>?)
      ?.map((e) => FdaPackagingDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  pharmClass: (json['pharm_class'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  listingExpirationDate: json['listing_expiration_date'] as String?,
);

FdaActiveIngredientDto _$FdaActiveIngredientDtoFromJson(
  Map<String, dynamic> json,
) => FdaActiveIngredientDto(
  name: json['name'] as String?,
  strength: json['strength'] as String?,
);

FdaPackagingDto _$FdaPackagingDtoFromJson(Map<String, dynamic> json) =>
    FdaPackagingDto(
      packageNdc: json['package_ndc'] as String?,
      description: json['description'] as String?,
      marketingStartDate: json['marketing_start_date'] as String?,
    );

FdaLabelResponseDto _$FdaLabelResponseDtoFromJson(Map<String, dynamic> json) =>
    FdaLabelResponseDto(
      meta: json['meta'] == null
          ? null
          : FdaMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => FdaLabelResultDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FdaLabelResultDto _$FdaLabelResultDtoFromJson(
  Map<String, dynamic> json,
) => FdaLabelResultDto(
  openfda: json['openfda'] == null
      ? null
      : FdaOpenFdaDto.fromJson(json['openfda'] as Map<String, dynamic>),
  indicationsAndUsage: (json['indications_and_usage'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  dosageAndAdministration: (json['dosage_and_administration'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  contraindications: (json['contraindications'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  warnings: (json['warnings'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  warningsAndCautions: (json['warnings_and_cautions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  adverseReactions: (json['adverse_reactions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  drugInteractions: (json['drug_interactions'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  description: (json['description'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  clinicalPharmacology: (json['clinical_pharmacology'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  mechanismOfAction: (json['mechanism_of_action'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  overdosage: (json['overdosage'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  pregnancy: (json['pregnancy'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  pediatricUse: (json['pediatric_use'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  geriatricUse: (json['geriatric_use'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  howSupplied: (json['how_supplied'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  storageAndHandling: (json['storage_and_handling'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  purpose: (json['purpose'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  activeIngredient: (json['active_ingredient'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  inactiveIngredient: (json['inactive_ingredient'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  splProductDataElements: (json['spl_product_data_elements'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

FdaOpenFdaDto _$FdaOpenFdaDtoFromJson(
  Map<String, dynamic> json,
) => FdaOpenFdaDto(
  applicationNumber: (json['application_number'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  brandName: (json['brand_name'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  genericName: (json['generic_name'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  manufacturerName: (json['manufacturer_name'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  productNdc: (json['product_ndc'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  productType: (json['product_type'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  route: (json['route'] as List<dynamic>?)?.map((e) => e as String).toList(),
  substanceName: (json['substance_name'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  rxcui: (json['rxcui'] as List<dynamic>?)?.map((e) => e as String).toList(),
  splId: (json['spl_id'] as List<dynamic>?)?.map((e) => e as String).toList(),
  splSetId: (json['spl_set_id'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  pharmClassEpc: (json['pharm_class_epc'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  pharmClassPe: (json['pharm_class_pe'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  pharmClassMoa: (json['pharm_class_moa'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

FdaDrugsResponseDto _$FdaDrugsResponseDtoFromJson(Map<String, dynamic> json) =>
    FdaDrugsResponseDto(
      meta: json['meta'] == null
          ? null
          : FdaMetaDto.fromJson(json['meta'] as Map<String, dynamic>),
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => FdaDrugsResultDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FdaDrugsResultDto _$FdaDrugsResultDtoFromJson(Map<String, dynamic> json) =>
    FdaDrugsResultDto(
      applicationNumber: json['application_number'] as String?,
      sponsorName: json['sponsor_name'] as String?,
      openfda: json['openfda'] == null
          ? null
          : FdaOpenFdaDto.fromJson(json['openfda'] as Map<String, dynamic>),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => FdaProductDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      submissions: (json['submissions'] as List<dynamic>?)
          ?.map((e) => FdaSubmissionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FdaProductDto _$FdaProductDtoFromJson(Map<String, dynamic> json) =>
    FdaProductDto(
      productNumber: json['product_number'] as String?,
      brandName: json['brand_name'] as String?,
      dosageForm: json['dosage_form'] as String?,
      route: json['route'] as String?,
      marketingStatus: json['marketing_status'] as String?,
      activeIngredients: (json['active_ingredients'] as List<dynamic>?)
          ?.map(
            (e) => FdaProductIngredientDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      teCode: json['te_code'] as String?,
      referenceDrug: json['reference_drug'] as String?,
      referenceStandard: json['reference_standard'] as String?,
    );

FdaProductIngredientDto _$FdaProductIngredientDtoFromJson(
  Map<String, dynamic> json,
) => FdaProductIngredientDto(
  name: json['name'] as String?,
  strength: json['strength'] as String?,
);

FdaSubmissionDto _$FdaSubmissionDtoFromJson(Map<String, dynamic> json) =>
    FdaSubmissionDto(
      submissionType: json['submission_type'] as String?,
      submissionNumber: json['submission_number'] as String?,
      submissionStatus: json['submission_status'] as String?,
      submissionStatusDate: json['submission_status_date'] as String?,
      reviewPriority: json['review_priority'] as String?,
      submissionClassCode: json['submission_class_code'] as String?,
      submissionClassCodeDescription:
          json['submission_class_code_description'] as String?,
    );

FdaMetaDto _$FdaMetaDtoFromJson(Map<String, dynamic> json) => FdaMetaDto(
  disclaimer: json['disclaimer'] as String?,
  terms: json['terms'] as String?,
  license: json['license'] as String?,
  lastUpdated: json['last_updated'] as String?,
  results: json['results'] == null
      ? null
      : FdaMetaResultsDto.fromJson(json['results'] as Map<String, dynamic>),
);

FdaMetaResultsDto _$FdaMetaResultsDtoFromJson(Map<String, dynamic> json) =>
    FdaMetaResultsDto(
      skip: (json['skip'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );
