import 'package:flutter/material.dart';
import '../models/disease_info.dart';
import '../widgets/ai_header_bar.dart';
import '../widgets/disease_info_block.dart';
import '../widgets/symptom_result_item.dart';

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
  Widget build(BuildContext context) {
    return Column(
      children: [
        AiHeaderBar(
          bySymptoms: _bySymptoms,
          queryController: _query,
          onToggleMode: () => setState(() => _bySymptoms = !_bySymptoms),
          onSearch: _search,
          onClear: () => setState(() { _query.clear(); _disease = null; _symptomMatches = []; }),
        ),
        Expanded(child: _bySymptoms ? _buildSymptoms() : _buildDisease())
      ],
    );
  }

  void _search() {
    final q = _query.text.trim().toLowerCase();
    if (q.isEmpty) return;
    final data = _mockData();
    if (_bySymptoms) {
      _symptomMatches = data.where((d) => d.symptoms.any((s) => s.toLowerCase().contains(q))).toList();
      _disease = null;
    } else {
      _disease = data.firstWhere(
        (d) => d.name.toLowerCase().contains(q),
        orElse: () => DiseaseInfo(name: 'Нет точного совпадения', description: 'Попробуйте изменить запрос', symptoms: const [], drugs: const []),
      );
      _symptomMatches = [];
    }
    setState(() {});
  }

  Widget _buildDisease() {
    if (_disease == null) {
      return Center(
        child: Text('Введите название заболевания для поиска', style: TextStyle(color: Colors.grey.shade700)),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_disease!.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DiseaseInfoBlock(title: 'Описание', content: _disease!.description, icon: Icons.description, color: Colors.green),
          DiseaseInfoBlock(title: 'Симптомы', content: _disease!.symptoms.join(', '), icon: Icons.warning, color: Colors.orange),
          DiseaseInfoBlock(title: 'Препараты', content: _disease!.drugs.join(', '), icon: Icons.medication, color: Colors.purple),
        ],
      ),
    );
  }

  Widget _buildSymptoms() {
    if (_symptomMatches.isEmpty) {
      return Center(
        child: Text('Введите симптомы: кашель, жар, одышка...', style: TextStyle(color: Colors.grey.shade700)),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _symptomMatches.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, i) => SymptomResultItem(disease: _symptomMatches[i]),
    );
  }

// _info method removed - replaced with DiseaseInfoBlock widget

  List<DiseaseInfo> _mockData() => const [
        DiseaseInfo(
          name: 'Артериальная гипертензия',
          description: 'Стойкое повышение артериального давления выше 140/90 мм рт. ст.',
          symptoms: ['головные боли', 'шум в ушах', 'головокружение', 'утомляемость'],
          drugs: ['ингибиторы АПФ', 'бета-блокаторы', 'диуретики'],
        ),
        DiseaseInfo(
          name: 'Сахарный диабет 2 типа',
          description: 'Нарушение углеводного обмена с хронической гипергликемией.',
          symptoms: ['жажда', 'частое мочеиспускание', 'слабость'],
          drugs: ['метформин', 'инсулин (при необходимости)'],
        ),
        DiseaseInfo(
          name: 'ОРВИ',
          description: 'Острое вирусное заболевание дыхательных путей.',
          symptoms: ['кашель', 'насморк', 'повышенная температура'],
          drugs: ['жаропонижающие', 'обильное питьё'],
        ),
      ];
}

