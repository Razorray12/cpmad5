import 'package:flutter/material.dart';

/// Панель поиска лекарств.
class DrugSearchPanel extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onClear;
  final bool isLoading;

  const DrugSearchPanel({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Поиск лекарств (OpenFDA)',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Название препарата (на англ.)',
                    prefixIcon: const Icon(Icons.medication_outlined),
                    suffixIcon: controller.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: onClear,
                          )
                        : null,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onSubmitted: (_) => onSearch(),
                  onChanged: (_) {
                    // Обновляем состояние для отображения кнопки очистки
                    (context as Element).markNeedsBuild();
                  },
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: isLoading ? null : onSearch,
                icon: isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.search),
                label: const Text('Найти'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Подсказки по поиску
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              _buildSuggestionChip(context, 'Aspirin'),
              _buildSuggestionChip(context, 'Ibuprofen'),
              _buildSuggestionChip(context, 'Metformin'),
              _buildSuggestionChip(context, 'Amoxicillin'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionChip(BuildContext context, String text) {
    return ActionChip(
      label: Text(text, style: const TextStyle(fontSize: 12)),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () {
        controller.text = text;
        onSearch();
      },
    );
  }
}
