import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/navigation/app_routes.dart';
import '../../../../presentation/state/app_scope.dart';
import '../../../shared/widgets/section_header.dart';
import '../widgets/patient_card.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionHeader(
          title: 'Список пациентов',
        ),
        // Кнопки навигации к показателям и консультациям
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.push(AppRoutes.v4),
                  icon: const Icon(Icons.favorite),
                  label: const Text('Все показатели'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => context.push(AppRoutes.v6),
                  icon: const Icon(Icons.event_note),
                  label: const Text('Все консультации'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade400,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final store = AppScope.of(context);
                    store.clearAllData();
                    await store.loadData();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Данные перезагружены')),
                      );
                    }
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Перезагрузить данные'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Поиск по имени, диагнозу или палате...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Observer(
            builder: (context) {
              final state = AppScope.of(context);
              final allPatients = state.patients.toList();
              
              // Локальная фильтрация
              final patients = _searchQuery.isEmpty
                  ? allPatients
                  : allPatients.where((patient) {
                      final lowerQuery = _searchQuery.toLowerCase();
                      return patient.fullName.toLowerCase().contains(lowerQuery) ||
                          patient.diagnosis.toLowerCase().contains(lowerQuery) ||
                          (patient.room?.toLowerCase().contains(lowerQuery) ?? false);
                    }).toList();

              if (patients.isEmpty) {
                return const Center(
                  child: Text('Пациенты не найдены',
                      style: TextStyle(fontSize: 16)),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: patients.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final p = patients[index];
                  return PatientCard(
                    patient: p,
                    onTap: () {
                      context.push('/patient/${p.id}', extra: p);
                    },
                    onDelete: () =>
                        AppScope.of(context).removePatient(p.id),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
