import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'shared/state/app_state.dart';
import 'shared/state/app_scope.dart';
import 'shared/theme/app_theme.dart';
import 'shared/navigation/app_router.dart';

void main() {
  runApp(const MediTrackApp());
}

class MediTrackApp extends StatefulWidget {
  const MediTrackApp({super.key});

  @override
  State<MediTrackApp> createState() => _MediTrackAppState();
}

class _MediTrackAppState extends State<MediTrackApp> {
  late final AppState _appState;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
    _router = AppRouter.createRouter();
    // Инициализируем данные один раз при запуске приложения
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _appState.initializeSampleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      notifier: _appState,
      child: MaterialApp.router(
        title: 'MediTrack',
        theme: AppTheme.lightTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
 
