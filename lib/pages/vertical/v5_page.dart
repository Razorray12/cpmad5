import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/vertical_step_page.dart';
import '../../features/chat/screens/chat_screen.dart';

class V5Page extends StatelessWidget {
  const V5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalStepPage(
      title: 'Чат',
      child: const ChatScreen(),
      nextLabel: 'На панель',
      onNext: () {
        context.go(AppRoutes.v1);
      },
    );
  }
}


