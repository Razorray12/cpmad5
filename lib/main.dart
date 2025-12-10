import 'package:flutter/material.dart';
import 'presentation/state/app_state.dart';
import 'presentation/state/app_scope.dart';
import 'ui/shared/theme/app_theme.dart';
import 'ui/shared/navigation/app_router.dart';
import 'ui/shared/di/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
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
