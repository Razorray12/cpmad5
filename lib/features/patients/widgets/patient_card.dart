import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../../../../shared/widgets/status_avatar.dart';
import '../../../../shared/widgets/entity_card.dart';

/// Карточка пациента
class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const PatientCard({
    super.key,
    required this.patient,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return EntityCard(
      leading: StatusAvatar(
        initial: patient.lastName,
        status: patient.status,
      ),
      title: patient.fullName,
      subtitleWidgets: [
        if (patient.room != null && patient.room!.isNotEmpty)
          Text('Палата: ${patient.room}'),
        Text('Диагноз: ${patient.diagnosis}'),
        Text(
          'Статус: ${patient.status}',
          style: TextStyle(color: StatusAvatar.colorForStatus(patient.status)),
        ),
      ],
      trailing: onDelete != null
          ? IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            )
          : null,
      onTap: onTap,
    );
  }
}
