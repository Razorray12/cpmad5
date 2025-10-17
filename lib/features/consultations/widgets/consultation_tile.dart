import 'package:flutter/material.dart';
import '../../../shared/widgets/entity_card.dart';
import '../../../shared/widgets/date_format.dart';
import '../../patients/models/patient.dart';
import '../models/consultation.dart';
import '../../../shared/state/app_scope.dart';

class ConsultationTile extends StatelessWidget {
  final Consultation consultation;
  const ConsultationTile({super.key, required this.consultation});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final patient = state.patients.firstWhere((p) => p.id == consultation.patientId, orElse: () =>
      const Patient(id: -1, firstName: 'Неизвестно', lastName: '', diagnosis: '', status: 'Неизвестно'));

    return EntityCard(
      title: patient.fullName,
      subtitleWidgets: [
        Text(formatDateTimeDDMMYYYYHHMM(consultation.dateTime)),
        if (consultation.doctorName != null) Text('Врач: ${consultation.doctorName}'),
        Text(consultation.note),
      ],
    );
  }
}


