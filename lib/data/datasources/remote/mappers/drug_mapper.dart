import '../../../../core/models/drug_info.dart';
import '../dto/drug_dto.dart';

/// Маппер для преобразования RxNorm DTO в бизнес-модели.
class DrugMapper {
  /// Преобразует ответ поиска RxNorm в результат поиска.
  static DrugSearchResult toSearchResult(RxNormDrugsResponseDto dto) {
    final conceptGroups = dto.drugGroup?.conceptGroup ?? [];
    final drugs = <DrugInfo>[];

    for (final group in conceptGroups) {
      final concepts = group.conceptProperties ?? [];
      for (final concept in concepts) {
        drugs.add(_conceptToDrugInfo(concept, group.tty));
      }
    }

    return DrugSearchResult(
      drugs: drugs,
      totalCount: drugs.length,
      skip: 0,
      limit: drugs.length,
    );
  }

  /// Преобразует концепцию RxNorm в DrugInfo.
  static DrugInfo _conceptToDrugInfo(
    RxNormConceptPropertiesDto concept,
    String? tty,
  ) {
    // Извлекаем компоненты из имени
    final parsed = _parseDrugName(concept.name ?? '');
    
    return DrugInfo(
      id: concept.rxcui ?? '',
      brandName: parsed.brandName,
      genericName: concept.synonym ?? parsed.genericName,
      description: _getDescriptionForTty(tty),
      doseForm: parsed.doseForm,
      strength: parsed.strength,
      route: parsed.route,
      productType: _translateTty(tty),
    );
  }

  /// Парсит имя препарата для извлечения компонентов.
  static _ParsedDrugName _parseDrugName(String name) {
    String brandName = name;
    String? genericName;
    String? doseForm;
    String? strength;
    String? route;

    // Ищем бренд в квадратных скобках [Brand Name]
    final brandMatch = RegExp(r'\[([^\]]+)\]').firstMatch(name);
    if (brandMatch != null) {
      brandName = brandMatch.group(1) ?? name;
      genericName = name.replaceAll(brandMatch.group(0)!, '').trim();
    }

    // Ищем дозировку (числа с единицами)
    final strengthMatch = RegExp(r'(\d+(?:\.\d+)?\s*(?:MG|MCG|ML|G|%|IU|UNIT))', caseSensitive: false)
        .firstMatch(name);
    if (strengthMatch != null) {
      strength = strengthMatch.group(1);
    }

    // Ищем форму выпуска
    final doseFormPatterns = [
      'Oral Tablet', 'Tablet', 'Capsule', 'Injectable', 'Solution', 
      'Suspension', 'Cream', 'Ointment', 'Gel', 'Patch', 'Spray',
      'Syrup', 'Drops', 'Inhaler', 'Suppository', 'Powder',
      'Extended Release', 'Delayed Release', 'Chewable',
    ];
    
    for (final pattern in doseFormPatterns) {
      if (name.toUpperCase().contains(pattern.toUpperCase())) {
        doseForm = pattern;
        break;
      }
    }

    // Ищем путь введения
    final routePatterns = {
      'Oral': 'Перорально',
      'Topical': 'Наружно',
      'Injectable': 'Инъекция',
      'Intravenous': 'Внутривенно',
      'Intramuscular': 'Внутримышечно',
      'Subcutaneous': 'Подкожно',
      'Inhalation': 'Ингаляция',
      'Rectal': 'Ректально',
      'Ophthalmic': 'Глазные',
      'Otic': 'Ушные',
      'Nasal': 'Назально',
    };
    
    for (final entry in routePatterns.entries) {
      if (name.toUpperCase().contains(entry.key.toUpperCase())) {
        route = entry.value;
        break;
      }
    }

    return _ParsedDrugName(
      brandName: brandName,
      genericName: genericName,
      doseForm: doseForm,
      strength: strength,
      route: route,
    );
  }

  /// Обогащает DrugInfo данными о связанных концепциях.
  static DrugInfo enrichWithRelated(
    DrugInfo drug,
    RxNormAllRelatedResponseDto dto,
  ) {
    final groups = dto.allRelatedGroup?.conceptGroup ?? [];
    
    final ingredients = <String>[];
    final brands = <String>[];
    
    for (final group in groups) {
      final concepts = group.conceptProperties ?? [];
      final tty = group.tty;
      
      for (final concept in concepts) {
        final name = concept.name ?? '';
        if (name.isEmpty) continue;
        
        switch (tty) {
          case 'IN':   // Ingredient
          case 'MIN':  // Multiple Ingredients
          case 'PIN':  // Precise Ingredient
            ingredients.add(name);
            break;
          case 'BN':   // Brand Name
            brands.add(name);
            break;
        }
      }
    }

    return drug.copyWith(
      relatedIngredients: ingredients,
      relatedBrands: brands,
      activeIngredients: ingredients.isNotEmpty ? ingredients : null,
    );
  }

  /// Обогащает DrugInfo данными о классах препарата.
  static DrugInfo enrichWithClasses(
    DrugInfo drug,
    RxClassResponseDto dto,
  ) {
    final concepts = dto.rxclassMinConceptList?.rxclassMinConcept ?? [];
    
    final therapeutic = <String>[];
    final pharmacologic = <String>[];
    
    for (final concept in concepts) {
      final className = concept.className;
      if (className == null) continue;
      
      switch (concept.classType) {
        case 'ATC1-4':
        case 'DISEASE':
        case 'EPC':
          therapeutic.add(className);
          break;
        case 'MOA':
        case 'PE':
        case 'CHEM':
          pharmacologic.add(className);
          break;
        default:
          therapeutic.add(className);
      }
    }

    return drug.copyWith(
      therapeuticClasses: therapeutic,
      pharmacologicClasses: pharmacologic,
    );
  }

  /// Обогащает DrugInfo данными о взаимодействиях.
  static DrugInfo enrichWithInteractions(
    DrugInfo drug,
    RxNormInteractionResponseDto dto,
  ) {
    final interactions = interactionsToStrings(dto);
    return drug.copyWith(drugInteractions: interactions);
  }

  /// Преобразует взаимодействия в список строк.
  static List<String> interactionsToStrings(RxNormInteractionResponseDto dto) {
    final interactions = <String>[];
    
    for (final group in dto.interactionTypeGroup ?? []) {
      for (final type in group.interactionType ?? []) {
        for (final pair in type.interactionPair ?? []) {
          if (pair.description != null) {
            final severity = pair.severity != null 
                ? ' [Серьёзность: ${_translateSeverity(pair.severity!)}]' 
                : '';
            interactions.add('${pair.description}$severity');
          }
        }
      }
    }
    
    return interactions;
  }

  /// Преобразует взаимодействия в модели.
  static List<DrugInteraction> interactionsToModels(RxNormInteractionResponseDto dto) {
    final interactions = <DrugInteraction>[];
    
    for (final group in dto.interactionTypeGroup ?? []) {
      for (final type in group.interactionType ?? []) {
        for (final pair in type.interactionPair ?? []) {
          if (pair.description != null && pair.interactionConcept != null) {
            final concepts = pair.interactionConcept!;
            String drug1 = '';
            String drug2 = '';
            
            if (concepts.length >= 2) {
              drug1 = concepts[0].minConceptItem?.name ?? '';
              drug2 = concepts[1].minConceptItem?.name ?? '';
            }
            
            interactions.add(DrugInteraction(
              description: pair.description!,
              severity: pair.severity,
              drug1Name: drug1,
              drug2Name: drug2,
            ));
          }
        }
      }
    }
    
    return interactions;
  }

  /// Обогащает DrugInfo данными из истории.
  static DrugInfo enrichWithHistory(
    DrugInfo drug,
    RxNormHistoryResponseDto dto,
  ) {
    final data = dto.rxcuiStatusHistory;
    final status = data?.metaData?.status;
    final attributes = data?.attributes;
    
    return drug.copyWith(
      status: status,
      strength: attributes?.availableStrength ?? drug.strength,
      doseForm: attributes?.doseFormName ?? drug.doseForm,
    );
  }

  /// Преобразует свойства препарата в DrugInfo.
  static DrugInfo propertiesToDrugInfo(RxNormPropertiesDto dto) {
    final parsed = _parseDrugName(dto.name ?? '');
    return DrugInfo(
      id: dto.rxcui ?? '',
      brandName: parsed.brandName,
      genericName: dto.synonym ?? parsed.genericName,
      description: _getDescriptionForTty(dto.tty),
      doseForm: parsed.doseForm,
      strength: parsed.strength,
      route: parsed.route,
      productType: _translateTty(dto.tty),
    );
  }

  /// Преобразует приблизительный поиск в результат.
  static DrugSearchResult approximateToSearchResult(
    RxNormApproximateResponseDto dto,
    List<RxNormPropertiesDto> properties,
  ) {
    final drugs = properties.map(propertiesToDrugInfo).toList();
    return DrugSearchResult(
      drugs: drugs,
      totalCount: drugs.length,
    );
  }

  /// Переводит серьёзность.
  static String _translateSeverity(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return 'Высокая';
      case 'low':
        return 'Низкая';
      case 'n/a':
        return 'Не определена';
      default:
        return severity;
    }
  }

  /// Получает описание на основе типа термина.
  static String? _getDescriptionForTty(String? tty) {
    switch (tty) {
      case 'SBD':
        return 'Брендированный препарат с указанием дозировки и формы выпуска';
      case 'SCD':
        return 'Клинический препарат с указанием дозировки и формы выпуска';
      case 'GPCK':
        return 'Упаковка генерического препарата';
      case 'BPCK':
        return 'Упаковка брендированного препарата';
      case 'IN':
        return 'Активное действующее вещество';
      case 'MIN':
        return 'Комбинация нескольких активных веществ';
      case 'PIN':
        return 'Точное активное вещество с указанием формы';
      case 'BN':
        return 'Торговое (брендовое) название препарата';
      case 'DF':
        return 'Лекарственная форма выпуска';
      case 'DFG':
        return 'Группа лекарственных форм';
      case 'SCDC':
        return 'Клинический препарат с компонентами';
      case 'SBDC':
        return 'Брендированный препарат с компонентами';
      default:
        return null;
    }
  }

  /// Переводит код типа термина.
  static String? _translateTty(String? tty) {
    switch (tty) {
      case 'SBD':
        return 'Брендированный препарат';
      case 'SCD':
        return 'Клинический препарат';
      case 'GPCK':
        return 'Упаковка';
      case 'BPCK':
        return 'Брендированная упаковка';
      case 'IN':
        return 'Ингредиент';
      case 'MIN':
        return 'Комбинация';
      case 'PIN':
        return 'Точный ингредиент';
      case 'BN':
        return 'Торговое название';
      case 'DF':
        return 'Лекарственная форма';
      case 'DFG':
        return 'Группа форм';
      case 'SCDC':
        return 'Клинический с компонентами';
      case 'SBDC':
        return 'Брендированный с компонентами';
      default:
        return tty;
    }
  }
}

/// Результат парсинга имени препарата.
class _ParsedDrugName {
  final String brandName;
  final String? genericName;
  final String? doseForm;
  final String? strength;
  final String? route;

  _ParsedDrugName({
    required this.brandName,
    this.genericName,
    this.doseForm,
    this.strength,
    this.route,
  });
}
