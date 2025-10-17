import 'package:flutter/material.dart';
import '../../../shared/state/app_scope.dart';
import '../models/patient.dart';
import '../widgets/patient_card.dart';
import '../widgets/patient_form.dart';
import '../../vitals/models/vital_sign.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/dialog_form_scaffold.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({super.key});

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final patients = state.patients;

    return Column(
      children: [
        SectionHeader(
          title: 'Список пациентов',
          actionIcon: Icons.add,
          actionLabel: 'Добавить',
          onAction: () => _showAddPatientDialog(context),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: patients.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final p = patients[index];
              return PatientCard(
                patient: p,
                onTap: () => _showPatientActions(context, p),
                onDelete: () => AppScope.of(context).removePatient(p.id),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddPatientDialog(BuildContext context) {
    final formKey = GlobalKey<PatientFormState>();

    showDialog(
      context: context,
      builder: (ctx) => DialogFormScaffold<PatientFormState>(
        title: 'Добавить пациента',
        formKey: formKey,
        submitLabel: 'Добавить',
        onSubmit: () => formKey.currentState?.submit(),
        child: PatientForm(
          key: formKey,
          onSubmit: ({
            required String firstName,
            required String lastName,
            String? middleName,
            String? birthDate,
            String? phoneNumber,
            required String diagnosis,
            String? room,
            String? sex,
            String? admissionDate,
            String? medications,
            String? allergies,
            String? mainDoctor,
            String? mainDoctorID,
            required String status,
          }) {
            AppScope.of(context).addPatient(
              firstName: firstName,
              lastName: lastName,
              middleName: middleName,
              birthDate: birthDate,
              phoneNumber: phoneNumber,
              diagnosis: diagnosis,
              room: room,
              sex: sex,
              admissionDate: admissionDate,
              medications: medications,
              allergies: allergies,
              mainDoctor: mainDoctor,
              mainDoctorID: mainDoctorID,
              status: status,
            );
            Navigator.pop(ctx);
          },
        ),
      ),
    );
  }

  void _showPatientActions(BuildContext context, Patient p) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.fullName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Диагноз: ${p.diagnosis}'),
            if (p.phoneNumber != null && p.phoneNumber!.isNotEmpty)
              Text('Телефон: ${p.phoneNumber}'),
            Text('Статус: ${p.status}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(ctx);
                      _showAddVitalsDialog(context, p.id);
                    },
                    icon: const Icon(Icons.favorite),
                    label: const Text('Добавить показатели'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(ctx),
                    icon: const Icon(Icons.close),
                    label: const Text('Закрыть'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showAddVitalsDialog(BuildContext context, int patientId) {
    final tCtrl = TextEditingController();
    final hrCtrl = TextEditingController();
    final rrCtrl = TextEditingController();
    final bpCtrl = TextEditingController();
    final spo2Ctrl = TextEditingController();
    final glucoseCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Показатели жизнедеятельности'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: tCtrl, decoration: const InputDecoration(labelText: 'Температура (строка)')),
              const SizedBox(height: 8),
              TextField(controller: hrCtrl, decoration: const InputDecoration(labelText: 'Пульс (строка)')),
              const SizedBox(height: 8),
              TextField(controller: rrCtrl, decoration: const InputDecoration(labelText: 'Дыхание (строка)')),
              const SizedBox(height: 8),
              TextField(controller: bpCtrl, decoration: const InputDecoration(labelText: 'АД (строка)')),
              const SizedBox(height: 8),
              TextField(controller: spo2Ctrl, decoration: const InputDecoration(labelText: 'SpO₂ (строка)')),
              const SizedBox(height: 8),
              TextField(controller: glucoseCtrl, decoration: const InputDecoration(labelText: 'Глюкоза крови')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (tCtrl.text.trim().isEmpty || hrCtrl.text.trim().isEmpty || rrCtrl.text.trim().isEmpty || bpCtrl.text.trim().isEmpty || spo2Ctrl.text.trim().isEmpty) return;
              final vital = VitalSign(
                timestamp: DateTime.now(),
                temperature: tCtrl.text.trim(),
                heartRate: hrCtrl.text.trim(),
                respiratoryRate: rrCtrl.text.trim(),
                bloodPressure: bpCtrl.text.trim(),
                oxygenSaturation: spo2Ctrl.text.trim(),
                bloodGlucose: glucoseCtrl.text.trim().isEmpty ? null : glucoseCtrl.text.trim(),
              );
              AppScope.of(context).addVital(patientId, vital);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Показатели сохранены')),
              );
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
