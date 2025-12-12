import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'presentation/state/app_state.dart';
import 'presentation/state/app_scope.dart';
import 'presentation/state/theme_state.dart';
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
    final themeState = getIt<ThemeState>();
    
    return AppScope(
      store: getIt<AppState>(),
      child: Observer(
        builder: (_) => MaterialApp.router(
          title: 'MediTrack',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
