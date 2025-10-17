import 'package:flutter/material.dart';
import '../../../shared/widgets/info_panel.dart';
import '../../patients/models/patient.dart';

class PatientSelectorPanel extends StatelessWidget {
  final List<Patient> patients;
  final int? selectedPatientId;
  final ValueChanged<int?> onPatientChanged;

  const PatientSelectorPanel({
    super.key,
    required this.patients,
    required this.selectedPatientId,
    required this.onPatientChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InfoPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Выберите пациента', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          DropdownButton<int>(
            isExpanded: true,
            value: selectedPatientId,
            hint: const Text('Нет пациентов'),
            items: patients
                .map((p) => DropdownMenuItem<int>(value: p.id, child: Text(p.fullName)))
                .toList(),
            onChanged: onPatientChanged,
          ),
        ],
      ),
    );
  }
}
