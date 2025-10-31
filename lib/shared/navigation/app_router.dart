import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/patients/screens/patient_list_screen.dart';
import '../../features/vitals/screens/vital_signs_screen.dart';
import '../../features/consultations/screens/consultations_screen.dart';
import '../../features/chat/screens/chat_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/patients/screens/patient_detail_screen.dart';
import '../../features/patients/models/patient.dart';
import '../widgets/app_shell_page.dart';
import '../state/app_scope.dart';

/// Маршрутная карта приложения с использованием GoRouter
class AppRouter {
  static const String dashboard = '/';
  static const String patients = '/patients';
  static const String vitals = '/vitals';
  static const String consultations = '/consultations';
  static const String chat = '/chat';
  static const String profile = '/profile';
  static const String patientDetail = '/patients/:patientId';

  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: dashboard,
      routes: [
        // Главные маршруты с bottom navigation
        GoRoute(
          path: dashboard,
          name: 'dashboard',
          builder: (context, state) => AppShellPage(
            currentIndex: 0,
            title: 'Панель',
            body: const DashboardScreen(),
          ),
        ),
        GoRoute(
          path: patients,
          name: 'patients',
          builder: (context, state) => AppShellPage(
            currentIndex: 1,
            title: 'Пациенты',
            body: const PatientListScreen(),
          ),
        ),
        GoRoute(
          path: vitals,
          name: 'vitals',
          builder: (context, state) => AppShellPage(
            currentIndex: 2,
            title: 'Показатели',
            body: const VitalSignsScreen(),
          ),
        ),
        GoRoute(
          path: consultations,
          name: 'consultations',
          builder: (context, state) => AppShellPage(
            currentIndex: 3,
            title: 'Консультации',
            body: const ConsultationsScreen(),
          ),
        ),
        GoRoute(
          path: chat,
          name: 'chat',
          builder: (context, state) => AppShellPage(
            currentIndex: 4,
            title: 'Чат',
            body: const ChatScreen(),
          ),
        ),
        GoRoute(
          path: profile,
          name: 'profile',
          builder: (context, state) => AppShellPage(
            currentIndex: 5,
            title: 'Профиль',
            body: const ProfileScreen(),
          ),
        ),
        // Вертикальная навигация - страница деталей пациента
        GoRoute(
          path: patientDetail,
          name: 'patientDetail',
          builder: (context, state) {
            // Получаем пациента из state.extra (передается при навигации)
            final patient = state.extra as Patient?;
            if (patient == null) {
              // Fallback: пытаемся получить по ID из path parameters
              final patientIdStr = state.pathParameters['patientId'];
              if (patientIdStr != null) {
                try {
                  final patientId = int.parse(patientIdStr);
                  final appState = AppScope.of(context);
                  final foundPatient = appState.patients.firstWhere(
                    (p) => p.id == patientId,
                    orElse: () => throw Exception('Patient not found'),
                  );
                  return PatientDetailScreen(patient: foundPatient);
                } catch (e) {
                  // Если пациент не найден, возвращаемся назад
                  context.go(patients);
                  return const SizedBox.shrink();
                }
              }
              context.go(patients);
              return const SizedBox.shrink();
            }
            return PatientDetailScreen(patient: patient);
          },
        ),
      ],
    );
  }
}

