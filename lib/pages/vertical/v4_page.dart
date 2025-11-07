import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../features/vitals/screens/vital_signs_screen.dart';

class V4Page extends StatelessWidget {
  const V4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalStepPage(
      title: 'Показатели',
      child: VitalSignsScreen(),
      showNextButton: false,
    );
  }
}


