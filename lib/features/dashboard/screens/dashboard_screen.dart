import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../shared/state/app_scope.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/status_stats_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final app = AppScope.of(context);
        final totalPatients = app.patients.length;
        final vitalsCount = app.patients
            .map((p) => app.vitalsFor(p.id).length)
            .fold<int>(0, (a, b) => a + b);
        final consultations = app.consultationsCount;
        final stable = app.patients
            .where((p) => p.status.toLowerCase() == 'стабилен')
            .length;
        final watch = app.patients
            .where((p) => p.status.toLowerCase() == 'под наблюдением')
            .length;
        final critical = app.patients
            .where((p) => p.status.toLowerCase() == 'критический')
            .length;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Пациентов',
                      value: '$totalPatients',
                      icon: Icons.people,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Показателей',
                      value: '$vitalsCount',
                      icon: Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Консультаций',
                      value: '$consultations',
                      icon: Icons.event_note,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DashboardStatCard(
                      title: 'Стабилен',
                      value: '$stable',
                      icon: Icons.check_circle,
                      color: Colors.blueGrey,
                    ),
                  ),
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
                    StatusStatsItem(
                      title: 'Под наблюдением',
                      value: '$watch',
                      icon: Icons.visibility,
                    ),
                    StatusStatsItem(
                      title: 'Критический',
                      value: '$critical',
                      icon: Icons.warning_amber,
                    ),
                    StatusStatsItem(
                      title: 'Стабилен',
                      value: '$stable',
                      icon: Icons.check_circle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
