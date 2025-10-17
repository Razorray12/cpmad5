import 'package:flutter/material.dart';
import '../../../shared/state/app_scope.dart';
import '../models/patient.dart';
import '../widgets/patient_card.dart';
import '../widgets/patient_form.dart';
import '../widgets/patient_actions_sheet.dart';
import '../../vitals/models/vital_sign.dart';
import '../../vitals/widgets/vital_form.dart';
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
      builder: (ctx) => PatientActionsSheet(
        patient: p,
        onAddVitals: () {
          Navigator.pop(ctx);
          _showAddVitalsDialog(context, p.id);
        },
        onClose: () => Navigator.pop(ctx),
      ),
    );
  }

  void _showAddVitalsDialog(BuildContext context, int patientId) {
    final formKey = GlobalKey<VitalFormState>();

    showDialog(
      context: context,
      builder: (ctx) => DialogFormScaffold<VitalFormState>(
        title: 'Показатели жизнедеятельности',
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
              timestamp: DateTime.now(),
              temperature: temperature,
              heartRate: heartRate,
              respiratoryRate: respiratoryRate,
              bloodPressure: bloodPressure,
              oxygenSaturation: oxygenSaturation,
              bloodGlucose: bloodGlucose,
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
}
