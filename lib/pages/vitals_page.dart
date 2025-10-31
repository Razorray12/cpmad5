import 'package:flutter/material.dart';
import '../shared/widgets/app_shell_page.dart';
import '../features/vitals/screens/vital_signs_screen.dart';

class VitalsPage extends StatelessWidget {
  const VitalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShellPage(
      currentIndex: 2,
      title: 'Показатели',
      body: VitalSignsScreen(),
    );
  }
}


