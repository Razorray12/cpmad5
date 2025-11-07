import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../navigation/app_routes.dart';
import 'package:go_router/go_router.dart';

class AppShellPage extends StatelessWidget {
  final int currentIndex;
  final String title;
  final Widget body;

  const AppShellPage({super.key, required this.currentIndex, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        automaticallyImplyLeading: false, // Отключаем кнопку "назад" для горизонтальной навигации
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Панель'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Пациенты'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Показатели'),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Консультации'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Чат'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;
    switch (index) {
      case 0:
        context.go(AppRoutes.dashboard);
        break;
      case 1:
        context.go(AppRoutes.patients);
        break;
      case 2:
        context.go(AppRoutes.vitals);
        break;
      case 3:
        context.go(AppRoutes.consultations);
        break;
      case 4:
        context.go(AppRoutes.chat);
        break;
      case 5:
        context.go(AppRoutes.profile);
        break;
    }
  }
}


