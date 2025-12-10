import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../presentation/state/app_scope.dart';
import '../../../../core/models/patient.dart';
import '../../../../core/models/vital_sign.dart';
import '../../../../core/models/consultation.dart';
import '../widgets/patient_card.dart';
import '../widgets/patient_edit_form.dart';
import '../../vitals/widgets/vital_card.dart';
import '../../vitals/widgets/vital_form.dart';
import '../../../shared/widgets/dialog_form_scaffold.dart';

/// Страница деталей пациента - пример вертикальной навигации (Navigator.push)
class PatientDetailScreen extends StatefulWidget {
  final Patient patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  State<PatientDetailScreen> createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  late int _patientId;

  @override
  void initState() {
    super.initState();
    _patientId = widget.patient.id;
  }

  Patient? _getCurrentPatient(BuildContext context) {
    final state = AppScope.of(context);
    try {
      return state.patients.firstWhere((p) => p.id == _patientId);
    } catch (_) {
      return widget.patient;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final state = AppScope.of(context);
        final patient = _getCurrentPatient(context);
        if (patient == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Пациент не найден')),
            body: const Center(child: Text('Пациент был удалён')),
          );
        }
        final vitals = state.vitalsFor(patient.id);
        final consultations = state.consultationsForPatient(patient.id);

        return Scaffold(
          appBar: AppBar(
            title: Text(patient.fullName),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Редактировать',
                onPressed: () => _showEditPatientDialog(context, patient),
              ),
            ],
          ),
          body: SingleChildScrollView(
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

                const SizedBox(height: 8),

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

                // Показатели пациента
                _buildSectionWithAction(
                  context: context,
                  title: 'Показатели (${vitals.length})',
                  actionLabel: 'Добавить',
                  onAction: () => _showAddVitalsDialog(context, patient.id),
                  children: vitals.isEmpty
                      ? [const Text('Нет показателей', style: TextStyle(color: Colors.grey))]
                      : vitals.map((vital) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: VitalCard(
                              vital: vital,
                              patientId: patient.id,
                              onDelete: () => state.removeVital(patient.id, vital),
                            ),
                          );
                        }).toList(),
                ),

                // Консультации пациента
                _buildSectionWithAction(
                  context: context,
                  title: 'Консультации (${consultations.length})',
                  actionLabel: 'Добавить',
                  onAction: () => _showAddConsultationDialog(context, patient.id),
                  children: consultations.isEmpty
                      ? [const Text('Нет консультаций', style: TextStyle(color: Colors.grey))]
                      : consultations.map((consultation) {
                          return Card(
                            child: ListTile(
                              leading: const Icon(Icons.event_note),
                              title: Text(consultation.note),
                              subtitle: Text(
                                '${_formatDateTime(consultation.dateTime)}${consultation.doctorName != null ? ' • ${consultation.doctorName}' : ''}',
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => state.removeConsultation(consultation),
                              ),
                            ),
                          );
                        }).toList(),
                ),
              ],
            ),
          ),
        );
      },
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

  Widget _buildSectionWithAction({
    required BuildContext context,
    required String title,
    required String actionLabel,
    required VoidCallback onAction,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add, size: 18),
              label: Text(actionLabel),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}.${dateTime.month}.${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showEditPatientDialog(BuildContext context, Patient patient) {
    final formKey = GlobalKey<PatientEditFormState>();

    showDialog(
      context: context,
      builder: (ctx) => DialogFormScaffold<PatientEditFormState>(
        title: 'Редактировать пациента',
        formKey: formKey,
        submitLabel: 'Сохранить',
        onSubmit: () => formKey.currentState?.submit(),
        child: PatientEditForm(
          key: formKey,
          patient: patient,
          onSubmit: (updatedPatient) {
            AppScope.of(context).updatePatient(updatedPatient);
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Данные пациента обновлены')),
            );
          },
        ),
      ),
    );
  }

  void _showAddVitalsDialog(BuildContext context, int patientId) {
    final formKey = GlobalKey<VitalFormState>();

    showDialog(
      context: context,
      builder: (ctx) => DialogFormScaffold<VitalFormState>(
        title: 'Добавить показатели',
        formKey: formKey,
        submitLabel: 'Сохранить',
        onSubmit: () => formKey.currentState?.submit(),
        child: VitalForm(
          key: formKey,
          onSubmit: ({
            required String temperature,
            required String heartRate,
            required String respiratoryRate,
            required String bloodPressure,
            required String oxygenSaturation,
            String? bloodGlucose,
          }) {
            final vital = VitalSign(
              patientId: patientId,
              timestamp: DateTime.now(),
              temperature: double.tryParse(temperature) ?? 36.6,
              heartRate: int.tryParse(heartRate) ?? 70,
              respiratoryRate: int.tryParse(respiratoryRate) ?? 16,
              bloodPressure: BloodPressure.fromString(bloodPressure),
              oxygenSaturation: int.tryParse(oxygenSaturation) ?? 98,
              bloodGlucose: bloodGlucose != null ? double.tryParse(bloodGlucose) : null,
            );
            AppScope.of(context).addVital(patientId, vital);
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Показатели сохранены')),
            );
          },
        ),
      ),
    );
  }

  void _showAddConsultationDialog(BuildContext context, int patientId) {
    final noteController = TextEditingController();
    final doctorController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Новая консультация'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: doctorController,
                decoration: const InputDecoration(
                  labelText: 'Врач (опционально)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: noteController,
                decoration: const InputDecoration(
                  labelText: 'Описание консультации',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (noteController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Введите описание')),
                );
                return;
              }
              AppScope.of(context).addConsultation(
                Consultation(
                  id: 0,
                  patientId: patientId,
                  dateTime: DateTime.now(),
                  doctorName: doctorController.text.trim().isEmpty
                      ? null
                      : doctorController.text.trim(),
                  note: noteController.text.trim(),
                ),
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Консультация добавлена')),
              );
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
