import 'package:flutter/material.dart';
import '../models/disease_info.dart';

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
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.medical_information, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    _bySymptoms ? 'Поиск по симптомам' : 'Справочник заболеваний',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => setState(() => _bySymptoms = !_bySymptoms),
                    icon: Icon(_bySymptoms ? Icons.medical_services : Icons.sick),
                    tooltip: _bySymptoms ? 'К поиску заболеваний' : 'К поиску по симптомам',
                  )
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _query,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: _bySymptoms ? 'Напр.: кашель, жар' : 'Напр.: гипертензия',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () => setState(() { _query.clear(); _disease = null; _symptomMatches = []; }),
                    icon: const Icon(Icons.clear),
                  ),
                ),
                onSubmitted: (_) => _search(),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: _search,
                  icon: const Icon(Icons.search),
                  label: const Text('Искать'),
                ),
              )
            ],
          ),
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
          _info('Описание', _disease!.description, Icons.description, Colors.green),
          _info('Симптомы', _disease!.symptoms.join(', '), Icons.warning, Colors.orange),
          _info('Препараты', _disease!.drugs.join(', '), Icons.medication, Colors.purple),
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
      itemBuilder: (_, i) {
        final d = _symptomMatches[i];
        return Card(
          child: ListTile(
            title: Text(d.name),
            subtitle: Text(d.description, maxLines: 2, overflow: TextOverflow.ellipsis),
          ),
        );
      },
    );
  }

  Widget _info(String title, String content, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(content),
              ],
            ),
          )
        ],
      ),
    );
  }

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

