import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';

class V1Page extends StatefulWidget {
  const V1Page({super.key});

  @override
  State<V1Page> createState() => _V1PageState();
}

class _V1PageState extends State<V1Page> {
  @override
  Widget build(BuildContext context) {
    return VerticalStepPage(
      title: 'Панель',
      nextRoute: AppRoutes.v2,
      nextLabel: 'К пациентам',
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.h1),
        icon: const Icon(Icons.playlist_add),
        label: const Text('Новая госпитализация'),
      ),
      child: const DashboardScreen(),
    );
  }
}
