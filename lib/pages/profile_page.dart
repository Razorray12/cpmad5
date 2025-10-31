import 'package:flutter/material.dart';
import '../shared/widgets/app_shell_page.dart';
import '../features/profile/screens/profile_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShellPage(
      currentIndex: 5,
      title: 'Профиль',
      body: ProfileScreen(),
    );
  }
}

