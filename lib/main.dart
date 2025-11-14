import 'package:flutter/material.dart';
import 'shared/state/app_state.dart';
import 'shared/state/app_scope.dart';
import 'shared/theme/app_theme.dart';
import 'shared/navigation/app_router.dart';
import 'shared/di/locator.dart';

void main() {
  setupLocator();
  runApp(const MediTrackApp());
}

class MediTrackApp extends StatelessWidget {
  const MediTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      store: getIt<AppState>(),
      child: MaterialApp.router(
        title: 'MediTrack',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.createRouter(),
      ),
    );
  }
}
 
