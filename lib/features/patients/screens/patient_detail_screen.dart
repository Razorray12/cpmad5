import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../shared/state/app_scope.dart';
import '../models/patient.dart';
import '../widgets/patient_card.dart';
import '../../vitals/models/vital_sign.dart';
import '../../vitals/widgets/vital_card.dart';
import '../../../shared/widgets/status_avatar.dart';
import '../../../shared/navigation/app_routes.dart';
import 'package:go_router/go_router.dart';

/// Страница деталей пациента - пример вертикальной навигации (Navigator.push)
class PatientDetailScreen extends StatelessWidget {
  final Patient patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(patient.fullName),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Observer(
        builder: (context) {
          final state = AppScope.of(context);
          final vitals = state.vitalsFor(patient.id);
          final consultations = state.consultationsForPatient(patient.id);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Карточка пациента
                PatientCard(
                  patient: patient,
                  onTap: null,
                ),
                const SizedBox(height: 24),

                // Быстрые действия
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push(AppRoutes.v4),
                        icon: const Icon(Icons.favorite),
                        label: const Text('К показателям'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push(AppRoutes.v6),
                        icon: const Icon(Icons.event_note),
                        label: const Text('К консультациям'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => context.push(AppRoutes.v5),
                        icon: const Icon(Icons.chat),
                        label: const Text('К чату'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Основная информация
                _buildSection(
                  title: 'Основная информация',
                  children: [
                    _buildInfoRow('Диагноз', patient.diagnosis),
                    if (patient.room != null && patient.room!.isNotEmpty)
                      _buildInfoRow('Палата', patient.room!),
                    if (patient.birthDate != null &&
                        patient.birthDate!.isNotEmpty)
                      _buildInfoRow('Дата рождения', patient.birthDate!),
                    if (patient.sex != null && patient.sex!.isNotEmpty)
                      _buildInfoRow('Пол', patient.sex!),
                    if (patient.admissionDate != null &&
                        patient.admissionDate!.isNotEmpty)
                      _buildInfoRow(
                          'Дата поступления', patient.admissionDate!),
                    if (patient.phoneNumber != null &&
                        patient.phoneNumber!.isNotEmpty)
                      _buildInfoRow('Телефон', patient.phoneNumber!),
                    if (patient.mainDoctor != null &&
                        patient.mainDoctor!.isNotEmpty)
                      _buildInfoRow('Лечащий врач', patient.mainDoctor!),
                  ],
                ),

                // Назначения и аллергии
                if (patient.medications != null &&
                        patient.medications!.isNotEmpty ||
                    patient.allergies != null &&
                        patient.allergies!.isNotEmpty)
                  _buildSection(
                    title: 'Медицинская информация',
                    children: [
                      if (patient.medications != null &&
                          patient.medications!.isNotEmpty)
                        _buildInfoRow('Назначения', patient.medications!),
                      if (patient.allergies != null &&
                          patient.allergies!.isNotEmpty)
                        _buildInfoRow(
                          'Аллергии',
                          patient.allergies!,
                          isWarning: true,
                        ),
                    ],
                  ),

                // Последние показатели
                if (vitals.isNotEmpty)
                  _buildSection(
                    title: 'Последние показатели',
                    children: vitals.take(3).map((vital) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: VitalCard(
                          vital: vital,
                          patientId: patient.id,
                        ),
                      );
                    }).toList(),
                  ),

                // Последние консультации
                if (consultations.isNotEmpty)
                  _buildSection(
                    title: 'Последние консультации',
                    children: consultations.take(3).map((consultation) {
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.event_note),
                          title: Text(consultation.note),
                          subtitle: Text(
                            '${_formatDateTime(consultation.dateTime)}${consultation.doctorName != null ? ' • ${consultation.doctorName}' : ''}',
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: children),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isWarning ? Colors.red : null,
                fontWeight: isWarning ? FontWeight.w500 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}

