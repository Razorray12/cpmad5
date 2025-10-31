import 'package:flutter/material.dart';
import 'shared/state/app_state.dart';
import 'shared/state/app_scope.dart';
import 'shared/theme/app_theme.dart';
import 'shared/navigation/app_routes.dart';
import 'pages/dashboard_page.dart';
import 'pages/patients_page.dart';
import 'pages/vitals_page.dart';
import 'pages/consultations_page.dart';
import 'pages/chat_page.dart';
import 'pages/profile_page.dart';

void main() {
  runApp(const MediTrackApp());
}

class MediTrackApp extends StatelessWidget {
  const MediTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: AppState(),
      child: MaterialApp(
        title: 'MediTrack',
        theme: AppTheme.lightTheme,
        initialRoute: AppRoutes.dashboard,
        routes: {
          AppRoutes.dashboard: (_) => const DashboardPage(),
          AppRoutes.patients: (_) => const PatientsPage(),
          AppRoutes.vitals: (_) => const VitalsPage(),
          AppRoutes.consultations: (_) => const ConsultationsPage(),
          AppRoutes.chat: (_) => const ChatPage(),
          AppRoutes.profile: (_) => const ProfilePage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
 
