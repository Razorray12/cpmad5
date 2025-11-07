import 'package:flutter/material.dart';
import 'shared/state/app_state.dart';
import 'shared/state/app_scope.dart';
import 'shared/theme/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'shared/navigation/app_router.dart';

void main() {
  runApp(const MediTrackApp());
}

class MediTrackApp extends StatelessWidget {
  const MediTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: AppState(),
      child: MaterialApp.router(
        title: 'MediTrack',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.createRouter(),
      ),
    );
  }
}
 
