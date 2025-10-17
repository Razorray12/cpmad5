import 'package:flutter/material.dart';
import '../../../shared/state/app_scope.dart';
import '../../../shared/theme/app_colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final totalPatients = app.patients.length;
    final vitalsCount = app.patients
        .map((p) => app.vitalsFor(p.id).length)
        .fold<int>(0, (a, b) => a + b);
    final consultations = app.consultationsCount;
    final stable = app.patients.where((p) => p.status.toLowerCase() == 'стабилен').length;
    final watch = app.patients.where((p) => p.status.toLowerCase() == 'под наблюдением').length;
    final critical = app.patients.where((p) => p.status.toLowerCase() == 'критический').length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.bars, AppColors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Панель управления MediTrack',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Сводка по пациентам и активности',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(child: _buildStatCard('Пациентов', '$totalPatients', Icons.people, Colors.green)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Показателей', '$vitalsCount', Icons.favorite, Colors.red)),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(child: _buildStatCard('Консультаций', '$consultations', Icons.event_note, Colors.orange)),
              const SizedBox(width: 12),
              Expanded(child: _buildStatCard('Стабилен', '$stable', Icons.check_circle, Colors.blueGrey)),
            ],
          ),

          const SizedBox(height: 20),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Статистика по статусам',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                _buildUpdateItem('Под наблюдением', '$watch', Icons.visibility),
                _buildUpdateItem('Критический', '$critical', Icons.warning_amber),
                _buildUpdateItem('Стабилен', '$stable', Icons.check_circle),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
