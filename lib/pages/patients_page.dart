import 'package:flutter/material.dart';
import '../shared/widgets/app_shell_page.dart';
import '../features/patients/screens/patient_list_screen.dart';

class PatientsPage extends StatelessWidget {
  const PatientsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShellPage(
      currentIndex: 1,
      title: 'Пациенты',
      body: PatientListScreen(),
    );
  }
}


