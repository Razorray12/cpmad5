import 'package:flutter/material.dart';
import '../../../../core/models/disease_info.dart';
import '../widgets/disease_info_block.dart';
import '../widgets/symptom_result_item.dart';

/// Экран ИИ-справочника по заболеваниям.
class AiReferenceScreen extends StatefulWidget {
  const AiReferenceScreen({super.key});

  @override
  State<AiReferenceScreen> createState() => _AiReferenceScreenState();
}

class _AiReferenceScreenState extends State<AiReferenceScreen> {
  final TextEditingController _query = TextEditingController();
  bool _bySymptoms = false;
  DiseaseInfo? _disease;
  List<DiseaseInfo> _symptomMatches = [];

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Заголовок
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.psychology,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'ИИ Справочник',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Поиск
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _query,
                      decoration: InputDecoration(
                        hintText: _bySymptoms 
                            ? 'Введите симптомы...' 
                            : 'Название заболевания...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _query.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: _clear,
                              )
                            : null,
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                      ),
                      onSubmitted: (_) => _search(),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _search,
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Переключатель режима
              Row(
                children: [
                  ChoiceChip(
                    label: const Text('По названию'),
                    selected: !_bySymptoms,
                    onSelected: (_) => setState(() => _bySymptoms = false),
                  ),
                  const SizedBox(width: 8),
                  ChoiceChip(
                    label: const Text('По симптомам'),
                    selected: _bySymptoms,
                    onSelected: (_) => setState(() => _bySymptoms = true),
        ),
                ],
              ),
            ],
          ),
        ),
        
        // Контент
        Expanded(
          child: _bySymptoms ? _buildSymptomsResult() : _buildDiseaseResult(),
        ),
      ],
    );
  }

  Widget _buildDiseaseResult() {
    if (_disease == null) {
      return _buildEmptyState(
        icon: Icons.medical_information_outlined,
        title: 'Поиск по названию',
        subtitle: 'Введите название заболевания для поиска\nили выберите из списка ниже',
        showQuickAccess: true,
      );
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              Text(
                _disease!.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Divider(height: 24),
              DiseaseInfoBlock(
                title: 'Описание',
                content: _disease!.description,
                icon: Icons.description,
                color: Colors.green,
              ),
              if (_disease!.symptoms.isNotEmpty)
                DiseaseInfoBlock(
                  title: 'Симптомы',
                  content: _disease!.symptoms.join(', '),
                  icon: Icons.warning,
                  color: Colors.orange,
                ),
              if (_disease!.drugs.isNotEmpty)
                DiseaseInfoBlock(
                  title: 'Рекомендуемые препараты',
                  content: _disease!.drugs.join(', '),
                  icon: Icons.medication,
                  color: Colors.purple,
                ),
        ],
          ),
        ),
      ),
    );
  }

  Widget _buildSymptomsResult() {
    if (_symptomMatches.isEmpty) {
      return _buildEmptyState(
        icon: Icons.health_and_safety_outlined,
        title: 'Поиск по симптомам',
        subtitle: 'Введите симптомы для поиска возможных заболеваний\n(например: кашель, головная боль, температура)',
        showQuickAccess: false,
      );
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _symptomMatches.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) => SymptomResultItem(disease: _symptomMatches[i]),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool showQuickAccess,
  }) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 32),
        Icon(icon, size: 64, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade500),
        ),
        if (showQuickAccess) ...[
          const SizedBox(height: 32),
          Text(
            'Популярные заболевания',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _mockData()
                .map((d) => ActionChip(
                      label: Text(d.name),
                      onPressed: () {
                        _query.text = d.name;
                        setState(() => _disease = d);
                      },
                    ))
                .toList(),
          ),
        ],
      ],
    );
  }

  void _clear() {
    _query.clear();
    setState(() {
      _disease = null;
      _symptomMatches = [];
    });
  }

  void _search() {
    final q = _query.text.trim().toLowerCase();
    if (q.isEmpty) return;
    
    final data = _mockData();
    
    if (_bySymptoms) {
      _symptomMatches = data
          .where((d) => d.symptoms.any((s) => s.toLowerCase().contains(q)))
          .toList();
      _disease = null;
    } else {
      _disease = data.firstWhere(
        (d) => d.name.toLowerCase().contains(q),
        orElse: () => const DiseaseInfo(
          name: 'Не найдено',
          description: 'Заболевание не найдено в базе данных. Попробуйте изменить запрос.',
          symptoms: [],
          drugs: [],
        ),
      );
      _symptomMatches = [];
    }
    setState(() {});
  }

  List<DiseaseInfo> _mockData() => const [
        DiseaseInfo(
          name: 'Артериальная гипертензия',
          description: 'Стойкое повышение артериального давления выше 140/90 мм рт. ст. Является одним из наиболее распространённых сердечно-сосудистых заболеваний.',
          symptoms: ['головные боли', 'шум в ушах', 'головокружение', 'утомляемость', 'носовые кровотечения'],
          drugs: ['ингибиторы АПФ', 'бета-блокаторы', 'диуретики', 'блокаторы кальциевых каналов'],
        ),
        DiseaseInfo(
          name: 'Сахарный диабет 2 типа',
          description: 'Хроническое нарушение углеводного обмена с гипергликемией вследствие инсулинорезистентности и относительной недостаточности инсулина.',
          symptoms: ['жажда', 'частое мочеиспускание', 'слабость', 'сухость кожи', 'зуд'],
          drugs: ['метформин', 'препараты сульфонилмочевины', 'инсулин'],
        ),
        DiseaseInfo(
          name: 'ОРВИ',
          description: 'Острая респираторная вирусная инфекция — группа клинически сходных острых инфекционных заболеваний, поражающих органы дыхания.',
          symptoms: ['кашель', 'насморк', 'повышенная температура', 'боль в горле', 'слабость'],
          drugs: ['жаропонижающие', 'сосудосуживающие капли', 'обильное питьё'],
        ),
        DiseaseInfo(
          name: 'Пневмония',
          description: 'Воспаление лёгочной ткани, как правило, инфекционного происхождения с преимущественным поражением альвеол.',
          symptoms: ['кашель с мокротой', 'высокая температура', 'одышка', 'боль в груди', 'слабость'],
          drugs: ['антибиотики', 'муколитики', 'жаропонижающие', 'бронхолитики'],
        ),
        DiseaseInfo(
          name: 'Гастрит',
          description: 'Воспаление слизистой оболочки желудка, приводящее к нарушению его функций и секреторной способности.',
          symptoms: ['боль в животе', 'тошнота', 'изжога', 'отрыжка', 'вздутие'],
          drugs: ['ингибиторы протонной помпы', 'антациды', 'гастропротекторы'],
        ),
        DiseaseInfo(
          name: 'Бронхиальная астма',
          description: 'Хроническое воспалительное заболевание дыхательных путей с повышенной реактивностью бронхов.',
          symptoms: ['одышка', 'свистящее дыхание', 'кашель', 'чувство заложенности в груди'],
          drugs: ['бронхолитики', 'ингаляционные глюкокортикостероиды', 'антилейкотриены'],
        ),
      ];
}
