import 'package:flutter/material.dart';
import 'shared/state/app_state.dart';
import 'shared/state/app_scope.dart';
import 'shared/theme/app_theme.dart';
import 'shared/navigation/app_routes.dart';
import 'pages/horizontal/h1_page.dart';
import 'pages/horizontal/h2_page.dart';
import 'pages/horizontal/h3_page.dart';
import 'pages/horizontal/h4_page.dart';
import 'pages/horizontal/h5_page.dart';
import 'pages/vertical/v1_page.dart';
import 'pages/vertical/v2_page.dart';
import 'pages/vertical/v3_page.dart';
import 'pages/vertical/v4_page.dart';
import 'pages/vertical/v5_page.dart';

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
        initialRoute: AppRoutes.v1,
        routes: {
          // Горизонтальная
          AppRoutes.h1: (_) => const H1Page(),
          AppRoutes.h2: (_) => const H2Page(),
          AppRoutes.h3: (_) => const H3Page(),
          AppRoutes.h4: (_) => const H4Page(),
          AppRoutes.h5: (_) => const H5Page(),
          // Вертикальная
          AppRoutes.v1: (_) => const V1Page(),
          AppRoutes.v2: (_) => const V2Page(),
          AppRoutes.v3: (_) => const V3Page(),
          AppRoutes.v4: (_) => const V4Page(),
          AppRoutes.v5: (_) => const V5Page(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
 
