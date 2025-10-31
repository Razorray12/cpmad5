import 'package:flutter/material.dart';
import '../shared/widgets/app_shell_page.dart';
import '../features/consultations/screens/consultations_screen.dart';

class ConsultationsPage extends StatelessWidget {
  const ConsultationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShellPage(
      currentIndex: 3,
      title: 'Консультации',
      body: ConsultationsScreen(),
    );
  }
}


