import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../shared/state/app_scope.dart';
import '../../features/patients/screens/patient_detail_screen.dart';

class V3Page extends StatelessWidget {
  const V3Page({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final patient = app.patients.isNotEmpty ? app.patients.first : null;
    return VerticalStepPage(
      title: 'Карточка пациента',
      child: patient == null
          ? const Center(child: Text('Нет пациентов'))
          : PatientDetailScreen(patient: patient),
      nextRoute: AppRoutes.v4,
      nextLabel: 'К показателям',
    );
  }
}


