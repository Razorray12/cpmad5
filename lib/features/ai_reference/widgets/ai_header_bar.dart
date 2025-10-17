import 'package:flutter/material.dart';

class AiHeaderBar extends StatelessWidget {
  final bool bySymptoms;
  final TextEditingController queryController;
  final VoidCallback onToggleMode;
  final VoidCallback onSearch;
  final VoidCallback onClear;

  const AiHeaderBar({
    super.key,
    required this.bySymptoms,
    required this.queryController,
    required this.onToggleMode,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                bySymptoms ? 'Поиск по симптомам' : 'Справочник заболеваний',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const Spacer(),
              IconButton(
                onPressed: onToggleMode,
                icon: Icon(bySymptoms ? Icons.medical_services : Icons.sick),
                tooltip: bySymptoms ? 'К поиску заболеваний' : 'К поиску по симптомам',
              )
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: queryController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: bySymptoms ? 'Напр.: кашель, жар' : 'Напр.: гипертензия',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                onPressed: onClear,
                icon: const Icon(Icons.clear),
              ),
            ),
            onSubmitted: (_) => onSearch(),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: onSearch,
              icon: const Icon(Icons.search),
              label: const Text('Искать'),
            ),
          )
        ],
      ),
    );
  }
}
