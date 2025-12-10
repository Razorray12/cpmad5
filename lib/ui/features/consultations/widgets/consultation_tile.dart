import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../shared/widgets/entity_card.dart';
import '../../../shared/widgets/date_format.dart';
import '../../../../core/models/patient.dart';
import '../../../../core/models/consultation.dart';
import '../../../../presentation/state/app_scope.dart';

class ConsultationTile extends StatelessWidget {
  final Consultation consultation;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  const ConsultationTile({super.key, required this.consultation, this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final state = AppScope.of(context);
        Patient? patient;
        try {
          patient = state.patients.firstWhere((p) => p.id == consultation.patientId);
        } catch (_) {
          patient = null;
        }

        return EntityCard(
          title: patient?.fullName ?? 'Неизвестный пациент',
          subtitleWidgets: [
            Text(formatDateTimeDDMMYYYYHHMM(consultation.dateTime)),
            if (consultation.doctorName != null)
              Text('Врач: ${consultation.doctorName}'),
            Text(consultation.note),
          ],
          trailing: (onDelete != null || onEdit != null)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onEdit != null)
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: onEdit,
                      ),
                    if (onDelete != null)
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: onDelete,
                      ),
                  ],
                )
              : null,
        );
      },
    );
  }
}
