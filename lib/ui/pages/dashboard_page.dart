import 'package:flutter/material.dart';
import '../shared/widgets/app_shell_page.dart';
import '../features/dashboard/screens/dashboard_screen.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShellPage(
      currentIndex: 0,
      title: 'Панель',
      body: DashboardScreen(),
    );
  }
}
