import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      leading: _buildPatientAvatar(),
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

  Widget _buildPatientAvatar() {
    final url = patient.imageUrl;
    final borderColor = StatusAvatar.colorForStatus(patient.status);

    if (url != null && url.isNotEmpty) {
      return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 2),
        ),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            errorWidget: (context, u, error) {
              debugPrint('Ошибка загрузки изображения: $u, ошибка: $error');
              return StatusAvatar(
                initial: patient.lastName,
                status: patient.status,
              );
            },
            placeholder: (context, u) => Container(
              color: Colors.grey[300],
              child: const Icon(Icons.person),
            ),
          ),
        ),
      );
    }
    return StatusAvatar(initial: patient.lastName, status: patient.status);
  }
}
