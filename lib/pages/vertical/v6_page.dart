import 'package:flutter/material.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../features/consultations/screens/consultations_screen.dart';

class V6Page extends StatelessWidget {
  const V6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalStepPage(
      title: 'Консультации',
      child: ConsultationsScreen(),
      showNextButton: false,
    );
  }
}



