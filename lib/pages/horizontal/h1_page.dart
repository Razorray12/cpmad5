import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/horizontal_step_page.dart';
import '../../features/ai_reference/screens/ai_reference_screen.dart';
import '../../shared/state/app_scope.dart';

class H1Page extends StatelessWidget {
  const H1Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Начинаем новый контекст госпитализации
    AppScope.of(context).clearAdmission();
    return const HorizontalStepPage(
      title: 'Госпитализация: Триаж и справка',
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: AiReferenceScreen(),
      ),
      nextRoute: AppRoutes.h2,
      nextLabel: 'К регистрации пациента',
    );
  }
}


