import 'package:flutter/material.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/patients/screens/patient_list_screen.dart';
import 'features/vitals/screens/vital_signs_screen.dart';
import 'features/consultations/screens/consultations_screen.dart';
import 'features/chat/screens/chat_screen.dart';
import 'features/ai_reference/screens/ai_reference_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'shared/state/app_scope.dart';

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Инициализируем тестовые данные при запуске приложения
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        AppScope.of(context).initializeSampleData();
      } catch (e) {
        print('Ошибка инициализации тестовых данных: $e');
      }
    });
  }

  final List<Widget> _screens = const [
    DashboardScreen(),
    PatientListScreen(),
    VitalSignsScreen(),
    ConsultationsScreen(),
    ChatScreen(),
    AiReferenceScreen(),
    ProfileScreen(),
  ];

  final List<String> _titles = const [
    'Панель',
    'Пациенты',
    'Показатели',
    'Консультации',
    'Чат',
    'AI-справочник',
    'Профиль',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Панель'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Пациенты'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Показатели'),
          BottomNavigationBarItem(icon: Icon(Icons.event_note), label: 'Консультации'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Чат'),
          BottomNavigationBarItem(icon: Icon(Icons.medical_information), label: 'AI'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        ],
      ),
    );
  }
}

