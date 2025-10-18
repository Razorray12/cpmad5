import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../../../../shared/widgets/status_avatar.dart';

class PatientActionsSheet extends StatelessWidget {
  final Patient patient;
  final VoidCallback onAddVitals;
  final VoidCallback onEdit;
  final VoidCallback onClose;

  const PatientActionsSheet({
    super.key,
    required this.patient,
    required this.onAddVitals,
    required this.onEdit,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            children: [
              StatusAvatar(
                initial: patient.lastName,
                status: patient.status,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patient.fullName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Статус: ${patient.status}', 
                         style: TextStyle(color: StatusAvatar.colorForStatus(patient.status))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Диагноз', patient.diagnosis),
          if (patient.room != null && patient.room!.isNotEmpty)
            _buildInfoRow('Палата', patient.room!),
          if (patient.phoneNumber != null && patient.phoneNumber!.isNotEmpty)
            _buildInfoRow('Телефон', patient.phoneNumber!),
          if (patient.birthDate != null && patient.birthDate!.isNotEmpty)
            _buildInfoRow('Дата рождения', patient.birthDate!),
          if (patient.sex != null && patient.sex!.isNotEmpty)
            _buildInfoRow('Пол', patient.sex!),
          if (patient.admissionDate != null && patient.admissionDate!.isNotEmpty)
            _buildInfoRow('Дата поступления', patient.admissionDate!),
          if (patient.mainDoctor != null && patient.mainDoctor!.isNotEmpty)
            _buildInfoRow('Лечащий врач', patient.mainDoctor!),
          if (patient.medications != null && patient.medications!.isNotEmpty)
            _buildInfoRow('Назначения', patient.medications!),
          if (patient.allergies != null && patient.allergies!.isNotEmpty)
            _buildInfoRow('Аллергии', patient.allergies!),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onAddVitals,
                  icon: const Icon(Icons.favorite),
                  label: const Text('Показатели'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit),
                  label: const Text('Редактировать'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onClose,
              icon: const Icon(Icons.close),
              label: const Text('Закрыть'),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text('$label:', style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
