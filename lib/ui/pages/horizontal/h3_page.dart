import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/horizontal_step_page.dart';
import '../../../presentation/state/app_scope.dart';
import '../../../core/models/vital_sign.dart';
import '../../features/vitals/widgets/vital_form.dart';

class H3Page extends StatefulWidget {
  const H3Page({super.key});

  @override
  State<H3Page> createState() => _H3PageState();
}

class _H3PageState extends State<H3Page> {
  final _formKey = GlobalKey<VitalFormState>();

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final patientId = app.admissionPatientId ?? 0;

    return HorizontalStepPage(
      title: 'Госпитализация: Первичные показатели',
      nextRoute: AppRoutes.h4,
      nextLabel: 'К первичной консультации',
      onNext: () {
        _formKey.currentState?.submit();
        context.go(AppRoutes.h4);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VitalForm(
          key: _formKey,
          onSubmit:
              ({
                required String temperature,
                required String heartRate,
                required String respiratoryRate,
                required String bloodPressure,
                required String oxygenSaturation,
                String? bloodGlucose,
              }) async {
                if (patientId == 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Сначала зарегистрируйте пациента'),
                    ),
                  );
                  return;
                }
                final vital = VitalSign(
                  patientId: patientId,
                  timestamp: DateTime.now(),
                  temperature: double.tryParse(temperature) ?? 36.6,
                  heartRate: int.tryParse(heartRate) ?? 70,
                  respiratoryRate: int.tryParse(respiratoryRate) ?? 16,
                  bloodPressure: BloodPressure.fromString(bloodPressure),
                  oxygenSaturation: int.tryParse(oxygenSaturation) ?? 98,
                  bloodGlucose: bloodGlucose != null
                      ? double.tryParse(bloodGlucose)
                      : null,
                );
                await app.addVital(patientId, vital);
                if (mounted) {
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
