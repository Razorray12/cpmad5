/// Бизнес-модель информации о лекарственном препарате.
class DrugInfo {
  final String id;
  final String brandName;
  final String? genericName;
  final String? manufacturer;
  final String? description;
  final List<String> activeIngredients;
  final List<String> indications;
  final List<String> warnings;
  final List<String> adverseReactions;
  final List<String> dosageInstructions;
  final List<String> contraindications;
  final List<String> drugInteractions;
  final String? route;
  final String? productType;
  
  // Расширенная информация
  final String? doseForm;
  final String? strength;
  final List<String> therapeuticClasses;
  final List<String> pharmacologicClasses;
  final List<String> relatedBrands;
  final List<String> relatedIngredients;
  final String? status;
  final List<String> ndcCodes;

  const DrugInfo({
    required this.id,
    required this.brandName,
    this.genericName,
    this.manufacturer,
    this.description,
    this.activeIngredients = const [],
    this.indications = const [],
    this.warnings = const [],
    this.adverseReactions = const [],
    this.dosageInstructions = const [],
    this.contraindications = const [],
    this.drugInteractions = const [],
    this.route,
    this.productType,
    this.doseForm,
    this.strength,
    this.therapeuticClasses = const [],
    this.pharmacologicClasses = const [],
    this.relatedBrands = const [],
    this.relatedIngredients = const [],
    this.status,
    this.ndcCodes = const [],
  });

  /// Создаёт копию с новыми значениями.
  DrugInfo copyWith({
    String? id,
    String? brandName,
    String? genericName,
    String? manufacturer,
    String? description,
    List<String>? activeIngredients,
    List<String>? indications,
    List<String>? warnings,
    List<String>? adverseReactions,
    List<String>? dosageInstructions,
    List<String>? contraindications,
    List<String>? drugInteractions,
    String? route,
    String? productType,
    String? doseForm,
    String? strength,
    List<String>? therapeuticClasses,
    List<String>? pharmacologicClasses,
    List<String>? relatedBrands,
    List<String>? relatedIngredients,
    String? status,
    List<String>? ndcCodes,
  }) {
    return DrugInfo(
      id: id ?? this.id,
      brandName: brandName ?? this.brandName,
      genericName: genericName ?? this.genericName,
      manufacturer: manufacturer ?? this.manufacturer,
      description: description ?? this.description,
      activeIngredients: activeIngredients ?? this.activeIngredients,
      indications: indications ?? this.indications,
      warnings: warnings ?? this.warnings,
      adverseReactions: adverseReactions ?? this.adverseReactions,
      dosageInstructions: dosageInstructions ?? this.dosageInstructions,
      contraindications: contraindications ?? this.contraindications,
      drugInteractions: drugInteractions ?? this.drugInteractions,
      route: route ?? this.route,
      productType: productType ?? this.productType,
      doseForm: doseForm ?? this.doseForm,
      strength: strength ?? this.strength,
      therapeuticClasses: therapeuticClasses ?? this.therapeuticClasses,
      pharmacologicClasses: pharmacologicClasses ?? this.pharmacologicClasses,
      relatedBrands: relatedBrands ?? this.relatedBrands,
      relatedIngredients: relatedIngredients ?? this.relatedIngredients,
      status: status ?? this.status,
      ndcCodes: ndcCodes ?? this.ndcCodes,
    );
  }

  /// Краткое описание препарата.
  String get shortDescription {
    if (description != null && description!.isNotEmpty) {
      final desc = description!;
      if (desc.length > 200) {
        return '${desc.substring(0, 200)}...';
      }
      return desc;
    }
    return genericName ?? brandName;
  }

  /// Проверка наличия предупреждений.
  bool get hasWarnings => warnings.isNotEmpty;

  /// Проверка наличия противопоказаний.
  bool get hasContraindications => contraindications.isNotEmpty;

  /// Полное название (бренд + общее название).
  String get fullName {
    if (genericName != null && genericName!.isNotEmpty) {
      return '$brandName ($genericName)';
    }
    return brandName;
  }

  /// Есть ли расширенная информация.
  bool get hasExtendedInfo =>
      therapeuticClasses.isNotEmpty ||
      pharmacologicClasses.isNotEmpty ||
      drugInteractions.isNotEmpty ||
      relatedBrands.isNotEmpty;

  /// Все классы препарата.
  List<String> get allClasses => [...therapeuticClasses, ...pharmacologicClasses];
}

/// Бизнес-модель отчёта о побочном эффекте.
class DrugAdverseEvent {
  final String reportId;
  final DateTime reportDate;
  final bool isSerious;
  final String? patientAge;
  final String? patientSex;
  final List<String> reactions;
  final List<AdverseEventDrug> drugs;

  const DrugAdverseEvent({
    required this.reportId,
    required this.reportDate,
    required this.isSerious,
    this.patientAge,
    this.patientSex,
    this.reactions = const [],
    this.drugs = const [],
  });

  /// Описание серьёзности.
  String get severityDescription => isSerious ? 'Серьёзный' : 'Не серьёзный';

  /// Пол пациента на русском.
  String? get patientSexRu {
    switch (patientSex) {
      case '1':
        return 'Мужской';
      case '2':
        return 'Женский';
      default:
        return null;
    }
  }
}

/// Информация о препарате в отчёте о побочном эффекте.
class AdverseEventDrug {
  final String name;
  final String? indication;
  final String? dosage;
  final String? route;
  final bool isPrimarySuspect;

  const AdverseEventDrug({
    required this.name,
    this.indication,
    this.dosage,
    this.route,
    this.isPrimarySuspect = false,
  });
}

/// Результат поиска лекарств.
class DrugSearchResult {
  final List<DrugInfo> drugs;
  final int totalCount;
  final int skip;
  final int limit;

  const DrugSearchResult({
    required this.drugs,
    required this.totalCount,
    this.skip = 0,
    this.limit = 10,
  });

  /// Есть ли ещё результаты для пагинации.
  bool get hasMore => skip + drugs.length < totalCount;

  /// Номер текущей страницы.
  int get currentPage => (skip ~/ limit) + 1;

  /// Общее количество страниц.
  int get totalPages => (totalCount / limit).ceil();
}

/// Взаимодействие препаратов.
class DrugInteraction {
  final String description;
  final String? severity;
  final String drug1Name;
  final String drug2Name;

  const DrugInteraction({
    required this.description,
    this.severity,
    required this.drug1Name,
    required this.drug2Name,
  });

  /// Цвет для отображения серьёзности.
  String get severityLevel {
    switch (severity?.toLowerCase()) {
      case 'high':
        return 'Высокая';
      case 'low':
        return 'Низкая';
      default:
        return severity ?? 'Неизвестная';
    }
  }
}
