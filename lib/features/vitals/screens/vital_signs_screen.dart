import 'package:flutter/material.dart';
import '../../../shared/state/app_scope.dart';
import '../models/vital_sign.dart';
import '../widgets/vital_card.dart';
import '../widgets/vital_form.dart';

class VitalSignsScreen extends StatefulWidget {
  const VitalSignsScreen({super.key});

  @override
  State<VitalSignsScreen> createState() => _VitalSignsScreenState();
}

class _VitalSignsScreenState extends State<VitalSignsScreen> {
  int? _selectedPatientId;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final patients = state.patients;
    _selectedPatientId ??= patients.isNotEmpty ? patients.first.id : null;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Выберите пациента', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                DropdownButton<int>(
                  isExpanded: true,
                  value: _selectedPatientId,
                  hint: const Text('Нет пациентов'),
                  items: patients
                      .map((p) => DropdownMenuItem<int>(value: p.id, child: Text(p.fullName)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedPatientId = v),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _selectedPatientId == null ? null : () => _showAddVitalsDialog(context, _selectedPatientId!),
                  icon: const Icon(Icons.add),
                  label: const Text('Добавить показатели'),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Text('История показателей', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildVitalsList(context),
        ],
      ),
    );
  }

  Widget _buildVitalsList(BuildContext context) {
    final state = AppScope.of(context);
    final id = _selectedPatientId;
    if (id == null) {
      return const Text('Добавьте пациента, чтобы вести показатели.');
    }
    final vitals = state.vitalsFor(id);
    if (vitals.isEmpty) {
      return const Text('Пока нет записей.');
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vitals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) => VitalCard(vital: vitals[index]),
    );
  }

  void _showAddVitalsDialog(BuildContext context, int patientId) {
    final formKey = GlobalKey<VitalFormState>();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Показатели жизнедеятельности'),
        content: VitalForm(
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
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () => formKey.currentState?.submit(),
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}
