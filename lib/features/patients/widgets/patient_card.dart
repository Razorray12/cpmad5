import 'package:flutter/material.dart';
import '../models/patient.dart';

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
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(patient.status),
          child: Text(
            patient.lastName.isNotEmpty ? patient.lastName[0] : '?',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          patient.fullName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (patient.room != null && patient.room!.isNotEmpty)
              Text('Палата: ${patient.room}'),
            Text('Диагноз: ${patient.diagnosis}'),
            Text(
              'Статус: ${patient.status}',
              style: TextStyle(color: _getStatusColor(patient.status)),
            ),
          ],
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              )
            : null,
        onTap: onTap,
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'стабилен':
        return Colors.green;
      case 'под наблюдением':
        return Colors.orange;
      case 'критический':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
