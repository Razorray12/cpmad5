import 'package:json_annotation/json_annotation.dart';

part 'fda_dto.g.dart';

// ============================================================================
// NDC Response DTOs
// ============================================================================

@JsonSerializable(createToJson: false)
class FdaNdcResponseDto {
  final FdaMetaDto? meta;
  final List<FdaNdcResultDto>? results;

  FdaNdcResponseDto({this.meta, this.results});

  factory FdaNdcResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FdaNdcResponseDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaNdcResultDto {
  @JsonKey(name: 'product_ndc')
  final String? productNdc;
  
  @JsonKey(name: 'generic_name')
  final String? genericName;
  
  @JsonKey(name: 'brand_name')
  final String? brandName;
  
  @JsonKey(name: 'brand_name_base')
  final String? brandNameBase;
  
  @JsonKey(name: 'labeler_name')
  final String? labelerName;
  
  @JsonKey(name: 'dosage_form')
  final String? dosageForm;
  
  @JsonKey(name: 'route')
  final List<String>? route;
  
  @JsonKey(name: 'marketing_category')
  final String? marketingCategory;
  
  @JsonKey(name: 'marketing_start_date')
  final String? marketingStartDate;
  
  @JsonKey(name: 'product_type')
  final String? productType;
  
  @JsonKey(name: 'active_ingredients')
  final List<FdaActiveIngredientDto>? activeIngredients;
  
  @JsonKey(name: 'packaging')
  final List<FdaPackagingDto>? packaging;
  
  @JsonKey(name: 'pharm_class')
  final List<String>? pharmClass;
  
  @JsonKey(name: 'listing_expiration_date')
  final String? listingExpirationDate;

  FdaNdcResultDto({
    this.productNdc,
    this.genericName,
    this.brandName,
    this.brandNameBase,
    this.labelerName,
    this.dosageForm,
    this.route,
    this.marketingCategory,
    this.marketingStartDate,
    this.productType,
    this.activeIngredients,
    this.packaging,
    this.pharmClass,
    this.listingExpirationDate,
  });

  factory FdaNdcResultDto.fromJson(Map<String, dynamic> json) =>
      _$FdaNdcResultDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaActiveIngredientDto {
  final String? name;
  final String? strength;

  FdaActiveIngredientDto({this.name, this.strength});

  factory FdaActiveIngredientDto.fromJson(Map<String, dynamic> json) =>
      _$FdaActiveIngredientDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaPackagingDto {
  @JsonKey(name: 'package_ndc')
  final String? packageNdc;
  
  final String? description;
  
  @JsonKey(name: 'marketing_start_date')
  final String? marketingStartDate;

  FdaPackagingDto({
    this.packageNdc,
    this.description,
    this.marketingStartDate,
  });

  factory FdaPackagingDto.fromJson(Map<String, dynamic> json) =>
      _$FdaPackagingDtoFromJson(json);
}

// ============================================================================
// Label Response DTOs
// ============================================================================

@JsonSerializable(createToJson: false)
class FdaLabelResponseDto {
  final FdaMetaDto? meta;
  final List<FdaLabelResultDto>? results;

  FdaLabelResponseDto({this.meta, this.results});

  factory FdaLabelResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FdaLabelResponseDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaLabelResultDto {
  @JsonKey(name: 'openfda')
  final FdaOpenFdaDto? openfda;
  
  @JsonKey(name: 'indications_and_usage')
  final List<String>? indicationsAndUsage;
  
  @JsonKey(name: 'dosage_and_administration')
  final List<String>? dosageAndAdministration;
  
  @JsonKey(name: 'contraindications')
  final List<String>? contraindications;
  
  @JsonKey(name: 'warnings')
  final List<String>? warnings;
  
  @JsonKey(name: 'warnings_and_cautions')
  final List<String>? warningsAndCautions;
  
  @JsonKey(name: 'adverse_reactions')
  final List<String>? adverseReactions;
  
  @JsonKey(name: 'drug_interactions')
  final List<String>? drugInteractions;
  
  @JsonKey(name: 'description')
  final List<String>? description;
  
  @JsonKey(name: 'clinical_pharmacology')
  final List<String>? clinicalPharmacology;
  
  @JsonKey(name: 'mechanism_of_action')
  final List<String>? mechanismOfAction;
  
  @JsonKey(name: 'overdosage')
  final List<String>? overdosage;
  
  @JsonKey(name: 'pregnancy')
  final List<String>? pregnancy;
  
  @JsonKey(name: 'pediatric_use')
  final List<String>? pediatricUse;
  
  @JsonKey(name: 'geriatric_use')
  final List<String>? geriatricUse;
  
  @JsonKey(name: 'how_supplied')
  final List<String>? howSupplied;
  
  @JsonKey(name: 'storage_and_handling')
  final List<String>? storageAndHandling;
  
  @JsonKey(name: 'purpose')
  final List<String>? purpose;
  
  @JsonKey(name: 'active_ingredient')
  final List<String>? activeIngredient;
  
  @JsonKey(name: 'inactive_ingredient')
  final List<String>? inactiveIngredient;
  
  @JsonKey(name: 'spl_product_data_elements')
  final List<String>? splProductDataElements;

  FdaLabelResultDto({
    this.openfda,
    this.indicationsAndUsage,
    this.dosageAndAdministration,
    this.contraindications,
    this.warnings,
    this.warningsAndCautions,
    this.adverseReactions,
    this.drugInteractions,
    this.description,
    this.clinicalPharmacology,
    this.mechanismOfAction,
    this.overdosage,
    this.pregnancy,
    this.pediatricUse,
    this.geriatricUse,
    this.howSupplied,
    this.storageAndHandling,
    this.purpose,
    this.activeIngredient,
    this.inactiveIngredient,
    this.splProductDataElements,
  });

  factory FdaLabelResultDto.fromJson(Map<String, dynamic> json) =>
      _$FdaLabelResultDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaOpenFdaDto {
  @JsonKey(name: 'application_number')
  final List<String>? applicationNumber;
  
  @JsonKey(name: 'brand_name')
  final List<String>? brandName;
  
  @JsonKey(name: 'generic_name')
  final List<String>? genericName;
  
  @JsonKey(name: 'manufacturer_name')
  final List<String>? manufacturerName;
  
  @JsonKey(name: 'product_ndc')
  final List<String>? productNdc;
  
  @JsonKey(name: 'product_type')
  final List<String>? productType;
  
  @JsonKey(name: 'route')
  final List<String>? route;
  
  @JsonKey(name: 'substance_name')
  final List<String>? substanceName;
  
  @JsonKey(name: 'rxcui')
  final List<String>? rxcui;
  
  @JsonKey(name: 'spl_id')
  final List<String>? splId;
  
  @JsonKey(name: 'spl_set_id')
  final List<String>? splSetId;
  
  @JsonKey(name: 'pharm_class_epc')
  final List<String>? pharmClassEpc;
  
  @JsonKey(name: 'pharm_class_pe')
  final List<String>? pharmClassPe;
  
  @JsonKey(name: 'pharm_class_moa')
  final List<String>? pharmClassMoa;

  FdaOpenFdaDto({
    this.applicationNumber,
    this.brandName,
    this.genericName,
    this.manufacturerName,
    this.productNdc,
    this.productType,
    this.route,
    this.substanceName,
    this.rxcui,
    this.splId,
    this.splSetId,
    this.pharmClassEpc,
    this.pharmClassPe,
    this.pharmClassMoa,
  });

  factory FdaOpenFdaDto.fromJson(Map<String, dynamic> json) =>
      _$FdaOpenFdaDtoFromJson(json);
}

// ============================================================================
// Drugs@FDA Response DTOs
// ============================================================================

@JsonSerializable(createToJson: false)
class FdaDrugsResponseDto {
  final FdaMetaDto? meta;
  final List<FdaDrugsResultDto>? results;

  FdaDrugsResponseDto({this.meta, this.results});

  factory FdaDrugsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FdaDrugsResponseDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaDrugsResultDto {
  @JsonKey(name: 'application_number')
  final String? applicationNumber;
  
  @JsonKey(name: 'sponsor_name')
  final String? sponsorName;
  
  @JsonKey(name: 'openfda')
  final FdaOpenFdaDto? openfda;
  
  @JsonKey(name: 'products')
  final List<FdaProductDto>? products;
  
  @JsonKey(name: 'submissions')
  final List<FdaSubmissionDto>? submissions;

  FdaDrugsResultDto({
    this.applicationNumber,
    this.sponsorName,
    this.openfda,
    this.products,
    this.submissions,
  });

  factory FdaDrugsResultDto.fromJson(Map<String, dynamic> json) =>
      _$FdaDrugsResultDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaProductDto {
  @JsonKey(name: 'product_number')
  final String? productNumber;
  
  @JsonKey(name: 'brand_name')
  final String? brandName;
  
  @JsonKey(name: 'dosage_form')
  final String? dosageForm;
  
  @JsonKey(name: 'route')
  final String? route;
  
  @JsonKey(name: 'marketing_status')
  final String? marketingStatus;
  
  @JsonKey(name: 'active_ingredients')
  final List<FdaProductIngredientDto>? activeIngredients;
  
  @JsonKey(name: 'te_code')
  final String? teCode;
  
  @JsonKey(name: 'reference_drug')
  final String? referenceDrug;
  
  @JsonKey(name: 'reference_standard')
  final String? referenceStandard;

  FdaProductDto({
    this.productNumber,
    this.brandName,
    this.dosageForm,
    this.route,
    this.marketingStatus,
    this.activeIngredients,
    this.teCode,
    this.referenceDrug,
    this.referenceStandard,
  });

  factory FdaProductDto.fromJson(Map<String, dynamic> json) =>
      _$FdaProductDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaProductIngredientDto {
  final String? name;
  final String? strength;

  FdaProductIngredientDto({this.name, this.strength});

  factory FdaProductIngredientDto.fromJson(Map<String, dynamic> json) =>
      _$FdaProductIngredientDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaSubmissionDto {
  @JsonKey(name: 'submission_type')
  final String? submissionType;
  
  @JsonKey(name: 'submission_number')
  final String? submissionNumber;
  
  @JsonKey(name: 'submission_status')
  final String? submissionStatus;
  
  @JsonKey(name: 'submission_status_date')
  final String? submissionStatusDate;
  
  @JsonKey(name: 'review_priority')
  final String? reviewPriority;
  
  @JsonKey(name: 'submission_class_code')
  final String? submissionClassCode;
  
  @JsonKey(name: 'submission_class_code_description')
  final String? submissionClassCodeDescription;

  FdaSubmissionDto({
    this.submissionType,
    this.submissionNumber,
    this.submissionStatus,
    this.submissionStatusDate,
    this.reviewPriority,
    this.submissionClassCode,
    this.submissionClassCodeDescription,
  });

  factory FdaSubmissionDto.fromJson(Map<String, dynamic> json) =>
      _$FdaSubmissionDtoFromJson(json);
}

// ============================================================================
// Common DTOs
// ============================================================================

@JsonSerializable(createToJson: false)
class FdaMetaDto {
  final String? disclaimer;
  final String? terms;
  final String? license;
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;
  final FdaMetaResultsDto? results;

  FdaMetaDto({
    this.disclaimer,
    this.terms,
    this.license,
    this.lastUpdated,
    this.results,
  });

  factory FdaMetaDto.fromJson(Map<String, dynamic> json) =>
      _$FdaMetaDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class FdaMetaResultsDto {
  final int? skip;
  final int? limit;
  final int? total;

  FdaMetaResultsDto({this.skip, this.limit, this.total});

  factory FdaMetaResultsDto.fromJson(Map<String, dynamic> json) =>
      _$FdaMetaResultsDtoFromJson(json);
}
