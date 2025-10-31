import 'package:flutter/material.dart';
import '../shared/widgets/app_shell_page.dart';
import '../features/chat/screens/chat_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShellPage(
      currentIndex: 4,
      title: 'Чат',
      body: ChatScreen(),
    );
  }
}


