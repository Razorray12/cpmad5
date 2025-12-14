import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../../presentation/state/app_scope.dart';
import '../../../../presentation/state/app_state.dart';
import '../../../../core/models/vital_sign.dart';
import '../widgets/vital_card.dart';
import '../widgets/vital_form.dart';
import '../widgets/patient_selector_panel.dart';
import '../../../shared/widgets/action_buttons.dart';
import '../../../shared/widgets/empty_state.dart';
import '../../../shared/widgets/dialog_form_scaffold.dart';

class VitalSignsScreen extends StatefulWidget {
  const VitalSignsScreen({super.key});

  @override
  State<VitalSignsScreen> createState() => _VitalSignsScreenState();
}

class _VitalSignsScreenState extends State<VitalSignsScreen> {
  int? _selectedPatientId;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final state = AppScope.of(context);
        final patients = state.patients;
        _selectedPatientId ??=
            patients.isNotEmpty ? patients.first.id : null;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PatientSelectorPanel(
                patients: patients,
                selectedPatientId: _selectedPatientId,
                onPatientChanged: (v) =>
                    setState(() => _selectedPatientId = v),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: PrimaryActionButton(
                      onPressed: _selectedPatientId == null
                          ? null
                          : () => _showAddVitalsDialog(
                              context, _selectedPatientId!),
                      icon: Icons.add,
                      label: 'Добавить показатели',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                'История показателей',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildVitalsList(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVitalsList(BuildContext context, AppState state) {
    final id = _selectedPatientId;
    if (id == null) {
      return const EmptyState(icon: Icons.info_outline, message: 'Добавьте пациента, чтобы вести показатели.');
    }
    final vitals = state.vitalsFor(id);
    if (vitals.isEmpty) {
      return const EmptyState(icon: Icons.history, message: 'Пока нет записей.');
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: vitals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (_, index) => VitalCard(
        vital: vitals[index],
        patientId: id,
        onDelete: () => AppScope.of(context).removeVital(id, vitals[index]),
      ),
    );
  }

  void _showAddVitalsDialog(BuildContext context, int patientId) {
    final formKey = GlobalKey<VitalFormState>();

    showDialog(
      context: context,
      builder: (ctx) => DialogFormScaffold<VitalFormState>(
        title: 'Показатели жизнедеятельности',
        formKey: formKey,
        submitLabel: 'Сохранить',
        onSubmit: () => formKey.currentState?.submit(),
        child: VitalForm(
          key: formKey,
          onSubmit: ({
            required String temperature,
            required String heartRate,
            required String respiratoryRate,
            required String bloodPressure,
            required String oxygenSaturation,
            String? bloodGlucose,
          }) async {
            final vital = VitalSign(
              patientId: patientId,
              timestamp: DateTime.now(),
              temperature: double.tryParse(temperature) ?? 36.6,
              heartRate: int.tryParse(heartRate) ?? 70,
              respiratoryRate: int.tryParse(respiratoryRate) ?? 16,
              bloodPressure: BloodPressure.fromString(bloodPressure),
              oxygenSaturation: int.tryParse(oxygenSaturation) ?? 98,
              bloodGlucose: bloodGlucose != null ? double.tryParse(bloodGlucose) : null,
            );
            await AppScope.of(context).addVital(patientId, vital);
            if (ctx.mounted) {
              Navigator.pop(ctx);
            }
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Показатели сохранены')),
              );
            }
          },
        ),
      ),
    );
  }
}
