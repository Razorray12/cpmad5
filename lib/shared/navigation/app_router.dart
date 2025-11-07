import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../../pages/vertical/v1_page.dart';
import '../../pages/vertical/v2_page.dart';
import '../../pages/vertical/v3_page.dart';
import '../../pages/vertical/v4_page.dart';
import '../../pages/vertical/v5_page.dart';
import '../../pages/horizontal/h1_page.dart';
import '../../pages/horizontal/h2_page.dart';
import '../../pages/horizontal/h3_page.dart';
import '../../pages/horizontal/h4_page.dart';
import '../../pages/horizontal/h5_page.dart';
import '../../features/patients/screens/patient_detail_screen.dart';
import '../../features/patients/models/patient.dart';

class AppRouter {
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: AppRoutes.v1,
      routes: [
        // Вертикальная
        GoRoute(path: AppRoutes.v1, builder: (_, __) => const V1Page()),
        GoRoute(path: AppRoutes.v2, builder: (_, __) => const V2Page()),
        GoRoute(path: AppRoutes.v3, builder: (_, __) => const V3Page()),
        GoRoute(path: AppRoutes.v4, builder: (_, __) => const V4Page()),
        GoRoute(path: AppRoutes.v5, builder: (_, __) => const V5Page()),

        // Горизонтальная
        GoRoute(path: AppRoutes.h1, builder: (_, __) => const H1Page()),
        GoRoute(path: AppRoutes.h2, builder: (_, __) => const H2Page()),
        GoRoute(path: AppRoutes.h3, builder: (_, __) => const H3Page()),
        GoRoute(path: AppRoutes.h4, builder: (_, __) => const H4Page()),
        GoRoute(path: AppRoutes.h5, builder: (_, __) => const H5Page()),

        GoRoute(
          path: '/patient/:id',
          builder: (context, state) {
            final idStr = state.pathParameters['id'];
            final intId = int.tryParse(idStr ?? '');
            final extra = state.extra;
            Patient? patient;
            if (extra is Patient) {
              patient = extra;
            }
            if (patient == null && intId != null) {
              final app = context.findAncestorWidgetOfExactType<InheritedWidget>();
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


