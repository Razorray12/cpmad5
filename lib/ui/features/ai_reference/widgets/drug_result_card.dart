import 'package:flutter/material.dart';
import '../../../../core/models/drug_info.dart';
import '../../medical/screens/drug_detail_screen.dart';

/// Карточка результата поиска лекарства в стиле FDA Drugs@FDA.
class DrugResultCard extends StatelessWidget {
  final DrugInfo drug;
  final DrugDetailSource source;

  const DrugResultCard({
    super.key, 
    required this.drug,
    this.source = DrugDetailSource.rxNorm,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final parsed = _parseDrugName(drug.brandName);
    
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: () => _openDetails(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок с названием препарата
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Бренд (если есть)
                  if (parsed.brandName != null) ...[
                    Text(
                      parsed.brandName!.toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                  
                  // Название препарата / активные вещества
                  Text(
                    parsed.displayName,
                    style: TextStyle(
                      fontSize: parsed.brandName != null ? 14 : 16,
                      fontWeight: parsed.brandName != null ? FontWeight.normal : FontWeight.bold,
                      color: parsed.brandName != null 
                          ? Colors.grey.shade700 
                          : theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Информация о препарате
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Активные вещества
                  if (parsed.ingredients.isNotEmpty) ...[
                    _buildInfoRow(
                      'Active Ingredient(s)',
                      'Действующие вещества',
                      parsed.ingredients.map((i) => 
                        '${i.name}${i.strength != null ? ' ${i.strength}' : ''}'
                      ).join('; '),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Форма выпуска
                  if (parsed.doseForm != null) ...[
                    _buildInfoRow(
                      'Dosage Form',
                      'Форма выпуска',
                      _translateDoseForm(parsed.doseForm!),
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Путь введения
                  if (drug.route != null) ...[
                    _buildInfoRow(
                      'Route',
                      'Путь введения',
                      drug.route!,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Тип продукта
                  if (drug.productType != null) ...[
                    _buildInfoRow(
                      'Product Type',
                      'Тип продукта',
                      drug.productType!,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // Статус
                  if (drug.status != null) ...[
                    _buildStatusRow(drug.status!),
                    const SizedBox(height: 12),
                  ],

                  // RxCUI идентификатор
                  _buildInfoRow(
                    'RxCUI',
                    'Идентификатор',
                    drug.id,
                  ),

                  // Кнопка подробнее
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => _openDetails(context),
                          icon: const Icon(Icons.description_outlined, size: 18),
                          label: const Text('Labeling / Инструкция'),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String labelEn, String labelRu, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                labelEn,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                labelRu,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusRow(String status) {
    final isActive = status.toLowerCase().contains('active') || 
                     status.toLowerCase().contains('activ');
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Marketing Status',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Статус',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: isActive ? Colors.green.shade100 : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isActive ? Icons.check_circle : Icons.info,
                size: 14,
                color: isActive ? Colors.green.shade700 : Colors.grey.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                status,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.green.shade700 : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _translateDoseForm(String form) {
    final translations = {
      'Oral Tablet': 'Таблетки для приёма внутрь',
      'Tablet': 'Таблетки',
      'Effervescent Oral Tablet': 'Шипучие таблетки',
      'Chewable Tablet': 'Жевательные таблетки',
      'Capsule': 'Капсулы',
      'Oral Capsule': 'Капсулы для приёма внутрь',
      'Solution': 'Раствор',
      'Oral Solution': 'Раствор для приёма внутрь',
      'Injectable': 'Раствор для инъекций',
      'Injectable Solution': 'Раствор для инъекций',
      'Cream': 'Крем',
      'Topical Cream': 'Крем для наружного применения',
      'Ointment': 'Мазь',
      'Gel': 'Гель',
      'Patch': 'Трансдермальный пластырь',
      'Spray': 'Спрей',
      'Nasal Spray': 'Назальный спрей',
      'Syrup': 'Сироп',
      'Drops': 'Капли',
      'Eye Drops': 'Глазные капли',
      'Inhaler': 'Ингалятор',
      'Suppository': 'Суппозитории (свечи)',
      'Powder': 'Порошок',
      'Suspension': 'Суспензия',
      'Pack': 'Комплект',
      'Extended Release': 'Пролонгированного действия',
    };
    return translations[form] ?? form;
  }

  void _openDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DrugDetailScreen(drug: drug, source: source),
      ),
    );
  }

  /// Парсит название препарата из RxNorm формата.
  _ParsedDrug _parseDrugName(String name) {
    String? brandName;
    String displayName = name;
    String? doseForm;
    final ingredients = <_IngredientInfo>[];

    // 1. Удаляем начальные паттерны типа "{1 (" или "{ 12 ("
    String cleanName = name.replaceAll(RegExp(r'^\{\s*\d+\s*\(\s*'), '');
    // Удаляем закрывающие скобки в конце
    cleanName = cleanName.replaceAll(RegExp(r'\s*\)\s*\}?\s*$'), '');
    
    // 2. Ищем бренд в квадратных скобках [Brand Name]
    final brandMatch = RegExp(r'\[([^\]]+)\]').firstMatch(cleanName);
    if (brandMatch != null) {
      brandName = brandMatch.group(1)?.trim();
      // Убираем бренд из строки для дальнейшего парсинга
      cleanName = cleanName.replaceAll(brandMatch.group(0)!, '').trim();
    }

    // 3. Определяем форму выпуска
    final doseFormPatterns = [
      'Extended Release Oral Tablet',
      'Delayed Release Oral Tablet', 
      'Chewable Oral Tablet',
      'Effervescent Oral Tablet',
      'Oral Tablet',
      'Oral Capsule',
      'Oral Solution',
      'Oral Suspension',
      'Injectable Solution',
      'Topical Cream',
      'Topical Ointment',
      'Nasal Spray',
      'Eye Drops',
      'Tablet',
      'Capsule',
      'Solution',
      'Suspension',
      'Cream',
      'Ointment',
      'Gel',
      'Patch',
      'Spray',
      'Syrup',
      'Drops',
      'Inhaler',
      'Suppository',
      'Powder',
      'Pack',
    ];
    
    for (final pattern in doseFormPatterns) {
      if (cleanName.toUpperCase().contains(pattern.toUpperCase())) {
        doseForm = pattern;
        break;
      }
    }

    // 4. Извлекаем ингредиенты с дозировками
    // Паттерн: название вещества + число + единица измерения
    final ingredientPattern = RegExp(
      r'([a-zA-Z][a-zA-Z\s-]{1,}?)\s+(\d+(?:\.\d+)?)\s*(MG|MCG|G|ML|%|UNIT|IU)',
      caseSensitive: false,
    );
    
    for (final match in ingredientPattern.allMatches(cleanName)) {
      final ingName = match.group(1)?.trim() ?? '';
      final amount = match.group(2) ?? '';
      final unit = match.group(3)?.toUpperCase() ?? '';
      
      // Исключаем служебные слова
      if (ingName.isNotEmpty && !_isExcludedWord(ingName)) {
        ingredients.add(_IngredientInfo(
          name: _formatIngredientName(ingName),
          strength: '$amount $unit',
        ));
      }
    }

    // 5. Формируем отображаемое имя
    if (ingredients.isNotEmpty) {
      // Показываем список ингредиентов
      displayName = ingredients.map((i) => 
        '${i.name} ${i.strength ?? ''}'.trim()
      ).join(' / ');
    } else if (brandName != null) {
      displayName = brandName;
    } else {
      // Очищаем название от лишних символов
      displayName = cleanName
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
      
      // Обрезаем слишком длинное название
      if (displayName.length > 80) {
        displayName = '${displayName.substring(0, 77)}...';
      }
    }

    return _ParsedDrug(
      brandName: brandName,
      displayName: displayName,
      doseForm: doseForm,
      strength: ingredients.length == 1 ? ingredients.first.strength : null,
      ingredients: ingredients,
    );
  }

  bool _isExcludedWord(String word) {
    final excluded = [
      'oral', 'tablet', 'capsule', 'solution', 'extended', 
      'release', 'delayed', 'pack', 'effervescent', 'chewable',
      'injectable', 'topical', 'nasal', 'spray', 'hbr', 'er',
      'dr', 'sr', 'xl', 'cr', 'la', 'in', 'per', 'and', 'with',
    ];
    return excluded.contains(word.toLowerCase().trim());
  }

  String _formatIngredientName(String name) {
    // Capitalize каждое слово
    return name.split(' ').map((word) {
      if (word.isEmpty) return word;
      // Сохраняем аббревиатуры (всё заглавными)
      if (word.toUpperCase() == word && word.length <= 4) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ').trim();
  }
}

class _ParsedDrug {
  final String? brandName;
  final String displayName;
  final String? doseForm;
  final String? strength;
  final List<_IngredientInfo> ingredients;

  _ParsedDrug({
    this.brandName,
    required this.displayName,
    this.doseForm,
    this.strength,
    required this.ingredients,
  });
}

class _IngredientInfo {
  final String name;
  final String? strength;
  _IngredientInfo({required this.name, this.strength});
}
