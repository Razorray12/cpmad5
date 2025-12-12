import 'package:flutter/material.dart';
import '../../../../core/models/drug_info.dart';
import '../../../shared/di/locator.dart';
import '../../../../data/datasources/remote/remote_drug_datasource.dart';
import '../../../../data/datasources/remote/remote_fda_datasource.dart';

/// Источник данных для детальной информации.
enum DrugDetailSource { rxNorm, fda }

/// Экран с детальной информацией о препарате в стиле FDA Drugs@FDA.
class DrugDetailScreen extends StatefulWidget {
  final DrugInfo drug;
  final DrugDetailSource source;

  const DrugDetailScreen({
    super.key, 
    required this.drug,
    this.source = DrugDetailSource.rxNorm,
  });

  @override
  State<DrugDetailScreen> createState() => _DrugDetailScreenState();
}

class _DrugDetailScreenState extends State<DrugDetailScreen> {
  late final RemoteDrugDataSource _rxNormDataSource;
  late final RemoteFdaDataSource _fdaDataSource;
  DrugInfo? _detailedDrug;
  FdaDrugDetails? _fdaDetails;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _rxNormDataSource = getIt<RemoteDrugDataSource>();
    _fdaDataSource = getIt<RemoteFdaDataSource>();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    setState(() => _isLoading = true);

    try {
      if (widget.source == DrugDetailSource.fda) {
        // Для FDA пытаемся получить расширенные данные по NDC
        final fdaDetails = await _fdaDataSource.getDrugDetailsByNdc(widget.drug.id);
        setState(() {
          _fdaDetails = fdaDetails;
          _detailedDrug = widget.drug;
          _isLoading = false;
        });
      } else {
        // Для RxNorm используем стандартный метод
        final details = await _rxNormDataSource.getDrugDetails(widget.drug.id);
        setState(() {
          _detailedDrug = details;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _detailedDrug = widget.drug;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final drug = _detailedDrug ?? widget.drug;
    final theme = Theme.of(context);
    final parsed = _parseDrugName(drug.brandName);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Информация о препарате'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Заголовок с названием
                  _buildHeader(drug, parsed, theme),
                  
                  // Основная информация
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Information
                        _buildSectionCard(
                          title: 'Product Information',
                          titleRu: 'Информация о препарате',
                          icon: Icons.medication,
                          children: [
                            if (parsed.ingredients.isNotEmpty)
                              _buildDetailRow(
                                'Active Ingredient(s)',
                                'Действующие вещества',
                                parsed.ingredients.map((i) => 
                                  '${i.name}${i.strength != null ? ' ${i.strength}' : ''}'
                                ).join(';\n'),
                              ),
                            if (drug.genericName != null)
                              _buildDetailRow(
                                'Nonproprietary Name',
                                'Непатентованное название',
                                drug.genericName!,
                              ),
                            if (parsed.doseForm != null)
                              _buildDetailRow(
                                'Dosage Form',
                                'Лекарственная форма',
                                _translateDoseForm(parsed.doseForm!),
                              ),
                            if (drug.strength != null)
                              _buildDetailRow(
                                'Strength',
                                'Дозировка',
                                drug.strength!,
                              ),
                            if (drug.route != null)
                              _buildDetailRow(
                                'Route of Administration',
                                'Путь введения',
                                drug.route!,
                              ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Regulatory Information
                        _buildSectionCard(
                          title: 'Regulatory Information',
                          titleRu: 'Регуляторная информация',
                          icon: Icons.verified_user,
                          children: [
                            _buildDetailRow(
                              'RxCUI',
                              'Идентификатор RxNorm',
                              drug.id,
                            ),
                            if (drug.productType != null)
                              _buildDetailRow(
                                'Application Type',
                                'Тип заявки',
                                drug.productType!,
                              ),
                            if (drug.status != null)
                              _buildStatusDetailRow(
                                'Marketing Status',
                                'Статус маркетинга',
                                drug.status!,
                              ),
                          ],
                        ),

                        // Терапевтические классы
                        if (drug.therapeuticClasses.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _buildSectionCard(
                            title: 'Therapeutic Equivalence',
                            titleRu: 'Терапевтическая эквивалентность',
                            icon: Icons.medical_services,
                            children: [
                              _buildChipSection(
                                'Therapeutic Class',
                                'Терапевтический класс',
                                drug.therapeuticClasses,
                                Colors.teal,
                              ),
                            ],
                          ),
                        ],

                        // Фармакологические классы
                        if (drug.pharmacologicClasses.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _buildSectionCard(
                            title: 'Pharmacologic Information',
                            titleRu: 'Фармакологическая информация',
                            icon: Icons.biotech,
                            children: [
                              _buildChipSection(
                                'Pharmacologic Class',
                                'Фармакологический класс',
                                drug.pharmacologicClasses,
                                Colors.purple,
                              ),
                            ],
                          ),
                        ],

                        // Связанные препараты
                        if (drug.relatedBrands.isNotEmpty || 
                            drug.relatedIngredients.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _buildSectionCard(
                            title: 'Related Products',
                            titleRu: 'Связанные препараты',
                            icon: Icons.account_tree,
                            children: [
                              if (drug.relatedBrands.isNotEmpty)
                                _buildChipSection(
                                  'Brand Names',
                                  'Торговые названия',
                                  drug.relatedBrands,
                                  Colors.blue,
                                ),
                              if (drug.relatedIngredients.isNotEmpty)
                                _buildChipSection(
                                  'Ingredients',
                                  'Ингредиенты',
                                  drug.relatedIngredients,
                                  Colors.indigo,
                                ),
                            ],
                          ),
                        ],

                        // Взаимодействия
                        if (drug.drugInteractions.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _buildSectionCard(
                            title: 'Drug Interactions',
                            titleRu: 'Лекарственные взаимодействия',
                            icon: Icons.warning_amber,
                            iconColor: Colors.orange,
                            children: [
                              _buildInteractionsList(drug.drugInteractions),
                            ],
                          ),
                        ],

                        // NDC коды
                        if (drug.ndcCodes.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          _buildSectionCard(
                            title: 'NDC Codes',
                            titleRu: 'Коды NDC',
                            icon: Icons.qr_code,
                            children: [
                              _buildChipSection(
                                'National Drug Code',
                                'Национальный код лекарства',
                                drug.ndcCodes.take(10).toList(),
                                Colors.grey,
                              ),
                              if (drug.ndcCodes.length > 10)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    '... и ещё ${drug.ndcCodes.length - 10} кодов',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],

                        // FDA Label информация
                        if (_fdaDetails?.labelInfo != null) ...[
                          const SizedBox(height: 16),
                          _buildFdaLabelSection(_fdaDetails!.labelInfo!),
                        ],

                        // Предупреждение
                        const SizedBox(height: 24),
                        _buildDisclaimer(),
                        
                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(DrugInfo drug, _ParsedDrug parsed, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Бренд
          if (parsed.brandName != null) ...[
            Text(
              parsed.brandName!.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 8),
          ],
          
          // Полное название / действующие вещества
          Text(
            parsed.displayName,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
          
          // Тип
          if (drug.description != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                drug.description!,
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String titleRu,
    required IconData icon,
    Color? iconColor,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок секции
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: iconColor ?? Colors.grey.shade700),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      titleRu,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Контент
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String labelEn, String labelRu, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
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
      ),
    );
  }

  Widget _buildStatusDetailRow(String labelEn, String labelRu, String status) {
    final isActive = status.toLowerCase().contains('active');
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.green.shade100 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isActive ? Icons.check_circle : Icons.info,
                  size: 16,
                  color: isActive ? Colors.green.shade700 : Colors.grey.shade600,
                ),
                const SizedBox(width: 6),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.green.shade700 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChipSection(
    String labelEn,
    String labelRu,
    List<String> items,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                labelEn,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '/ $labelRu',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 13,
                    color: color.withValues(alpha: 0.9),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionsList(List<String> interactions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: interactions.take(5).map((interaction) {
        final isHigh = interaction.toLowerCase().contains('высокая') ||
                       interaction.toLowerCase().contains('high');
        
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHigh ? Colors.red.shade50 : Colors.orange.shade50,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isHigh ? Colors.red.shade200 : Colors.orange.shade200,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                isHigh ? Icons.warning : Icons.info_outline,
                size: 18,
                color: isHigh ? Colors.red.shade600 : Colors.orange.shade600,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  interaction,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDisclaimer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info, color: Colors.amber.shade700, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Важное предупреждение',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Данная информация носит исключительно справочный характер и не является '
                  'медицинским советом или рекомендацией к самолечению. Перед применением любого '
                  'лекарственного препарата обязательно проконсультируйтесь с врачом или фармацевтом.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber.shade900,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFdaLabelSection(FdaLabelInfo label) {
    final List<Widget> allSections = [];
    
    // Описание препарата
    if (label.description != null && label.description!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Description',
        'Описание препарата',
        label.description!,
        Icons.info_outline,
        Colors.blue,
      ));
    }
    
    // Показания к применению
    if (label.indicationsAndUsage != null && 
        label.indicationsAndUsage!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Indications and Usage',
        'Показания к применению',
        label.indicationsAndUsage!,
        Icons.medical_services,
        Colors.green,
      ));
    }
    
    // Дозировка и применение
    if (label.dosageAndAdministration != null &&
        label.dosageAndAdministration!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Dosage and Administration',
        'Дозировка и способ применения',
        label.dosageAndAdministration!,
        Icons.medication_liquid,
        Colors.teal,
      ));
    }
    
    // Механизм действия
    if (label.mechanismOfAction != null && 
        label.mechanismOfAction!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Mechanism of Action',
        'Механизм действия',
        label.mechanismOfAction!,
        Icons.biotech,
        Colors.purple,
      ));
    }
    
    // Противопоказания
    if (label.contraindications != null &&
        label.contraindications!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Contraindications',
        'Противопоказания',
        label.contraindications!,
        Icons.block,
        Colors.red,
      ));
    }
    
    // Предупреждения
    if (label.warnings != null && label.warnings!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Warnings',
        'Предупреждения и меры предосторожности',
        label.warnings!,
        Icons.warning_amber,
        Colors.orange,
      ));
    }
    
    // Побочные реакции
    if (label.adverseReactions != null && label.adverseReactions!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Adverse Reactions',
        'Побочные реакции',
        label.adverseReactions!,
        Icons.healing,
        Colors.deepOrange,
      ));
    }
    
    // Лекарственные взаимодействия
    if (label.drugInteractions != null && label.drugInteractions!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Drug Interactions',
        'Лекарственные взаимодействия',
        label.drugInteractions!,
        Icons.compare_arrows,
        Colors.amber,
      ));
    }
    
    // Передозировка
    if (label.overdosage != null && label.overdosage!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'Overdosage',
        'Передозировка',
        label.overdosage!,
        Icons.dangerous,
        Colors.red.shade700,
      ));
    }
    
    // Форма выпуска
    if (label.howSupplied != null && label.howSupplied!.isNotEmpty) {
      allSections.add(_buildLabelCard(
        'How Supplied',
        'Форма выпуска и хранение',
        label.howSupplied!,
        Icons.inventory_2,
        Colors.blueGrey,
      ));
    }
    
    if (allSections.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Заголовок раздела
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Icon(Icons.description, size: 20, color: Colors.blue.shade700),
              const SizedBox(width: 8),
              Text(
                'Официальная инструкция FDA',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
        ),
        // Карточки с информацией
        ...allSections,
      ],
    );
  }

  Widget _buildLabelCard(
    String titleEn,
    String titleRu,
    String content,
    IconData icon,
    Color color,
  ) {
    // Ограничиваем текст
    final displayText = content.length > 1000 
        ? '${content.substring(0, 997)}...'
        : content;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: color.withValues(alpha: 0.3)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Icon(icon, color: color, size: 24),
        title: Text(
          titleRu,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        subtitle: Text(
          titleEn,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade500,
          ),
        ),
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              displayText,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _translateDoseForm(String form) {
    final translations = {
      'Oral Tablet': 'Таблетки для приёма внутрь',
      'Tablet': 'Таблетки',
      'Extended Release Oral Tablet': 'Таблетки пролонгированного действия',
      'Delayed Release Oral Tablet': 'Таблетки с отсроченным высвобождением',
      'Chewable Oral Tablet': 'Жевательные таблетки',
      'Effervescent Oral Tablet': 'Шипучие таблетки',
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
    };
    return translations[form] ?? form;
  }

  /// Парсит название препарата из RxNorm формата.
  _ParsedDrug _parseDrugName(String name) {
    String? brandName;
    String displayName = name;
    String? doseForm;
    final ingredients = <_IngredientInfo>[];

    // 1. Удаляем начальные паттерны типа "{1 (" или "{ 12 ("
    String cleanName = name.replaceAll(RegExp(r'^\{\s*\d+\s*\(\s*'), '');
    cleanName = cleanName.replaceAll(RegExp(r'\s*\)\s*\}?\s*$'), '');
    
    // 2. Ищем бренд в квадратных скобках [Brand Name]
    final brandMatch = RegExp(r'\[([^\]]+)\]').firstMatch(cleanName);
    if (brandMatch != null) {
      brandName = brandMatch.group(1)?.trim();
      cleanName = cleanName.replaceAll(brandMatch.group(0)!, '').trim();
    }

    // 3. Определяем форму выпуска
    final doseFormPatterns = [
      'Extended Release Oral Tablet',
      'Delayed Release Oral Tablet', 
      'Chewable Oral Tablet',
      'Effervescent Oral Tablet',
      'Oral Tablet', 'Oral Capsule', 'Oral Solution',
      'Injectable Solution', 'Topical Cream',
      'Nasal Spray', 'Eye Drops',
      'Tablet', 'Capsule', 'Solution', 'Cream', 'Ointment',
      'Gel', 'Patch', 'Spray', 'Syrup', 'Drops', 'Pack',
    ];
    
    for (final pattern in doseFormPatterns) {
      if (cleanName.toUpperCase().contains(pattern.toUpperCase())) {
        doseForm = pattern;
        break;
      }
    }

    // 4. Извлекаем ингредиенты
    final ingredientPattern = RegExp(
      r'([a-zA-Z][a-zA-Z\s-]{1,}?)\s+(\d+(?:\.\d+)?)\s*(MG|MCG|G|ML|%|UNIT|IU)',
      caseSensitive: false,
    );
    
    for (final match in ingredientPattern.allMatches(cleanName)) {
      final ingName = match.group(1)?.trim() ?? '';
      final amount = match.group(2) ?? '';
      final unit = match.group(3)?.toUpperCase() ?? '';
      
      final excluded = ['oral', 'tablet', 'capsule', 'solution', 'extended', 
        'release', 'delayed', 'pack', 'effervescent', 'chewable',
        'injectable', 'topical', 'nasal', 'spray', 'hbr', 'er',
        'dr', 'sr', 'xl', 'cr', 'la', 'in', 'per', 'and', 'with'];
      
      if (ingName.isNotEmpty && !excluded.contains(ingName.toLowerCase().trim())) {
        ingredients.add(_IngredientInfo(
          name: ingName.split(' ').map((w) {
            if (w.isEmpty) return w;
            return w[0].toUpperCase() + w.substring(1).toLowerCase();
          }).join(' ').trim(),
          strength: '$amount $unit',
        ));
      }
    }

    // 5. Формируем отображаемое имя
    if (ingredients.isNotEmpty) {
      displayName = ingredients.map((i) => 
        '${i.name} ${i.strength ?? ''}'.trim()
      ).join(' / ');
    } else if (brandName != null) {
      displayName = brandName;
    } else {
      displayName = cleanName.replaceAll(RegExp(r'\s+'), ' ').trim();
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
