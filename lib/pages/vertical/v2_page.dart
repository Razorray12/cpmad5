import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../features/patients/screens/patient_list_screen.dart';

class V2Page extends StatelessWidget {
  const V2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalStepPage(
      title: 'Пациенты',
      child: PatientListScreen(),
      showNextButton: false,
    );
  }
}


