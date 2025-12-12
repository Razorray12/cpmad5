import 'package:flutter/material.dart';
import '../../../../core/models/covid_stats.dart';

/// Карточка глобальной статистики COVID-19.
class CovidStatsCard extends StatelessWidget {
  final CovidGlobalStats stats;

  const CovidStatsCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.public,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Глобальная статистика COVID-19',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            
            // Основные показатели
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Всего случаев',
                    stats.formattedCases,
                    '+${_formatNumber(stats.todayCases)} сегодня',
                    Colors.orange,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Смертей',
                    stats.formattedDeaths,
                    '+${_formatNumber(stats.todayDeaths)} сегодня',
                    Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Выздоровело',
                    stats.formattedRecovered,
                    '${stats.recoveryRate.toStringAsFixed(1)}%',
                    Colors.green,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Активные',
                    _formatNumber(stats.activeCases),
                    '${stats.activeRate.toStringAsFixed(1)}% от всех',
                    Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Критические',
                    _formatNumber(stats.criticalCases),
                    '',
                    Colors.purple,
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Стран затронуто',
                    stats.affectedCountries.toString(),
                    '',
                    Colors.teal,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            // Время обновления
            Text(
              'Обновлено: ${_formatDateTime(stats.updatedAt)}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    String subtitle,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
        ),
        if (subtitle.isNotEmpty)
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade500,
                ),
          ),
      ],
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.'
        '${dateTime.month.toString().padLeft(2, '0')}.'
        '${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }
}
