import 'package:flutter/material.dart';
import '../shared/widgets/app_shell_page.dart';
import '../shared/state/app_scope.dart';
import '../features/dashboard/screens/dashboard_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Инициализируем тестовые данные при запуске приложения
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        AppScope.of(context).initializeSampleData();
      } catch (e) {
        print('Ошибка инициализации тестовых данных: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const AppShellPage(
      currentIndex: 0,
      title: 'Панель',
      body: DashboardScreen(),
    );
  }
}


