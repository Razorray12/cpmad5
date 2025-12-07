import 'package:flutter/material.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../features/chat/screens/chat_screen.dart';

class V5Page extends StatelessWidget {
  const V5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const VerticalStepPage(
      title: 'Чат медперсонала',
      child: ChatScreen(),
      showNextButton: false,
    );
  }
}


