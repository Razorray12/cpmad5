import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../../../shared/navigation/app_router.dart' as router;

/// Обертка страницы с bottom navigation для горизонтальной навигации
class AppShellPage extends StatelessWidget {
  final int currentIndex;
  final String title;
  final Widget body;

  const AppShellPage({
    super.key,
    required this.currentIndex,
    required this.title,
    required this.body,
  });

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

  /// Горизонтальная навигация через GoRouter (pushReplacement аналог)
  void _onTap(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        context.go(router.AppRouter.dashboard);
        break;
      case 1:
        context.go(router.AppRouter.patients);
        break;
      case 2:
        context.go(router.AppRouter.vitals);
        break;
      case 3:
        context.go(router.AppRouter.consultations);
        break;
      case 4:
        context.go(router.AppRouter.chat);
        break;
      case 5:
        context.go(router.AppRouter.profile);
        break;
    }
  }
}

