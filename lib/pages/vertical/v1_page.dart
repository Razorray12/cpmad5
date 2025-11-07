import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../shared/state/app_scope.dart';

class V1Page extends StatefulWidget {
  const V1Page({super.key});

  @override
  State<V1Page> createState() => _V1PageState();
}

class _V1PageState extends State<V1Page> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final app = AppScope.of(context);
      if (app.patients.isEmpty) {
        app.initializeSampleData();
      }
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return VerticalStepPage(
      title: 'Панель',
      child: const DashboardScreen(),
      nextRoute: AppRoutes.v2,
      nextLabel: 'К пациентам',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.h1),
        icon: const Icon(Icons.playlist_add),
        label: const Text('Новая госпитализация'),
      ),
    );
  }
}


