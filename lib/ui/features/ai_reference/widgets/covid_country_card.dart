import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/models/covid_stats.dart';

/// Карточка статистики COVID-19 по стране.
class CovidCountryCard extends StatelessWidget {
  final CovidCountryStats stats;

  const CovidCountryCard({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок с флагом
            Row(
              children: [
                if (stats.flagUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: stats.flagUrl!,
                      width: 32,
                      height: 24,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 32,
                        height: 24,
                        color: Colors.grey.shade200,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.flag,
                        size: 24,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stats.country,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      if (stats.continent != null)
                        Text(
                          stats.continent!,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Colors.grey.shade600,
                              ),
                        ),
                    ],
                  ),
                ),
                if (stats.countryCode != null)
                  Chip(
                    label: Text(stats.countryCode!),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
              ],
            ),
            const Divider(height: 24),
            
            // Статистика
            _buildStatsGrid(context),
            
            const SizedBox(height: 16),
            
            // Дополнительные показатели
            Row(
              children: [
                _buildSmallStat(
                  context,
                  'На 1М населения',
                  stats.casesPerMillion.toStringAsFixed(0),
                  Icons.people,
                ),
                const SizedBox(width: 16),
                _buildSmallStat(
                  context,
                  'Смертность',
                  '${stats.mortalityRate.toStringAsFixed(2)}%',
                  Icons.trending_down,
                ),
                const SizedBox(width: 16),
                _buildSmallStat(
                  context,
                  'Тестов',
                  _formatNumber(stats.totalTests),
                  Icons.biotech,
                ),
              ],
            ),
            
            const SizedBox(height: 12),
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

  Widget _buildStatsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatTile(
                context,
                'Случаев',
                _formatNumber(stats.totalCases),
                '+${_formatNumber(stats.todayCases)}',
                Colors.orange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatTile(
                context,
                'Смертей',
                _formatNumber(stats.totalDeaths),
                '+${_formatNumber(stats.todayDeaths)}',
                Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _buildStatTile(
                context,
                'Выздоровело',
                _formatNumber(stats.totalRecovered),
                '+${_formatNumber(stats.todayRecovered)}',
                Colors.green,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildStatTile(
                context,
                'Активные',
                _formatNumber(stats.activeCases),
                '${stats.criticalCases} крит.',
                Colors.blue,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatTile(
    BuildContext context,
    String label,
    String value,
    String subtitle,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color.withValues(alpha: 0.8),
                ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
          ),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStat(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade500),
          const SizedBox(width: 4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade500,
                        fontSize: 10,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
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
