import 'package:flutter/material.dart';
import '../models/patient.dart';

class PatientActionsSheet extends StatelessWidget {
  final Patient patient;
  final VoidCallback onAddVitals;
  final VoidCallback onClose;

  const PatientActionsSheet({
    super.key,
    required this.patient,
    required this.onAddVitals,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(patient.fullName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Диагноз: ${patient.diagnosis}'),
          if (patient.phoneNumber != null && patient.phoneNumber!.isNotEmpty)
            Text('Телефон: ${patient.phoneNumber}'),
          Text('Статус: ${patient.status}'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onAddVitals,
                  icon: const Icon(Icons.favorite),
                  label: const Text('Добавить показатели'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onClose,
                  icon: const Icon(Icons.close),
                  label: const Text('Закрыть'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
