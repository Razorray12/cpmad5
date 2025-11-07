import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/horizontal_step_page.dart';
import '../../shared/state/app_scope.dart';
import '../../features/vitals/models/vital_sign.dart';
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: VitalForm(
          key: _formKey,
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
            if (patientId != 0) app.addVital(patientId, vital);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Показатели сохранены')));
          },
        ),
      ),
      nextRoute: AppRoutes.h4,
      nextLabel: 'К первичной консультации',
      onNext: () {
        _formKey.currentState?.submit();
        Navigator.pushReplacementNamed(context, AppRoutes.h4);
      },
    );
  }
}


