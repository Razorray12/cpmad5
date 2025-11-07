import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/horizontal_step_page.dart';
import '../../shared/state/app_scope.dart';
import '../../features/patients/widgets/patient_card.dart';
import '../../features/vitals/widgets/vital_card.dart';
import '../../features/consultations/models/consultation.dart';

class H5Page extends StatelessWidget {
  const H5Page({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final patient = app.admissionPatient;
    final vitals = patient == null ? [] : app.vitalsFor(patient.id);
    final consultations = patient == null ? <Consultation>[] : app.consultationsForPatient(patient.id);

    return HorizontalStepPage(
      title: 'Госпитализация: Итог',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (patient == null) ...[
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 24.0),
                  child: Text('Пациент не зарегистрирован. Итог недоступен.'),
                ),
              ),
            ] else ...[
              PatientCard(patient: patient, onTap: null),
              const SizedBox(height: 16),
              if (vitals.isNotEmpty) ...[
                const Text('Последние показатели'),
                const SizedBox(height: 8),
                VitalCard(vital: vitals.last, patientId: patient.id),
                const SizedBox(height: 16),
              ] else ...[
                const Text('Показатели не внесены'),
                const SizedBox(height: 16),
              ],
              if (consultations.isNotEmpty) ...[
                const Text('Последняя консультация'),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.event_note),
                    title: Text(consultations.last.note),
                    subtitle: Text('${consultations.last.dateTime}'),
                  ),
                ),
              ] else ...[
                const Text('Консультации не добавлены'),
              ],
            ],
          ],
        ),
      ),
      nextRoute: AppRoutes.v1,
      nextLabel: 'Завершить и перейти на панель',
      onNext: () {
        app.clearAdmission();
        Navigator.pushReplacementNamed(context, AppRoutes.v1);
      },
    );
  }
}


