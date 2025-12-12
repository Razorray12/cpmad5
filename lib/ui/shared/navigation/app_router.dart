import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../di/locator.dart';
import '../../features/auth/state/auth_state.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../pages/vertical/v1_page.dart';
import '../../pages/vertical/v2_page.dart';
import '../../pages/vertical/v3_page.dart';
import '../../pages/vertical/v4_page.dart';
import '../../pages/vertical/v5_page.dart';
import '../../pages/vertical/v6_page.dart';
import '../../pages/vertical/v7_page.dart';
import '../../pages/horizontal/h1_page.dart';
import '../../pages/horizontal/h2_page.dart';
import '../../pages/horizontal/h3_page.dart';
import '../../pages/horizontal/h4_page.dart';
import '../../pages/horizontal/h5_page.dart';
import '../../features/patients/screens/patient_detail_screen.dart';
import '../../../core/models/patient.dart';

class AppRouter {
  static GoRouter? _router;

  static GoRouter get router {
    _router ??= _createRouter();
    return _router!;
  }

  static GoRouter _createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.login,
      redirect: (context, state) {
        final auth = getIt<AuthState>();
        final isAuthenticated = auth.isAuthenticated;
        final isAuthRoute = state.matchedLocation == AppRoutes.login || 
                           state.matchedLocation == AppRoutes.register;
        
        // Если не авторизован и не на странице авторизации - редирект на логин
        if (!isAuthenticated && !isAuthRoute) {
          return AppRoutes.login;
        }
        
        // Если авторизован и на странице авторизации - редирект на главную
        if (isAuthenticated && isAuthRoute) {
          return AppRoutes.v1;
        }
        
        return null;
      },
      routes: [
        // Авторизация
        GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
        GoRoute(path: AppRoutes.register, builder: (_, __) => const RegisterScreen()),
        
        // Вертикальная навигация (основные экраны)
        GoRoute(path: AppRoutes.v1, builder: (_, __) => const V1Page()),
        GoRoute(path: AppRoutes.v2, builder: (_, __) => const V2Page()),
        GoRoute(path: AppRoutes.v3, builder: (_, __) => const V3Page()),
        GoRoute(path: AppRoutes.v4, builder: (_, __) => const V4Page()),
        GoRoute(path: AppRoutes.v5, builder: (_, __) => const V5Page()),
        GoRoute(path: AppRoutes.v6, builder: (_, __) => const V6Page()),
        GoRoute(path: AppRoutes.v7, builder: (_, __) => const V7Page()),

        // Горизонтальная навигация (процесс госпитализации)
        GoRoute(path: AppRoutes.h1, builder: (_, __) => const H1Page()),
        GoRoute(path: AppRoutes.h2, builder: (_, __) => const H2Page()),
        GoRoute(path: AppRoutes.h3, builder: (_, __) => const H3Page()),
        GoRoute(path: AppRoutes.h4, builder: (_, __) => const H4Page()),
        GoRoute(path: AppRoutes.h5, builder: (_, __) => const H5Page()),

        // Детали пациента
        GoRoute(
          path: '/patient/:id',
          builder: (context, state) {
            final extra = state.extra;
            Patient? patient;
            if (extra is Patient) {
              patient = extra;
            }
            if (patient == null) {
              return const Scaffold(body: Center(child: Text('Пациент не найден')));
            }
            return PatientDetailScreen(patient: patient);
          },
        ),
      ],
    );
  }
}
