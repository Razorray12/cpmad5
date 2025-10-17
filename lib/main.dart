import 'package:flutter/material.dart';
import 'shared/state/app_state.dart';
import 'shared/state/app_scope.dart';
import 'shared/theme/app_theme.dart';
import 'root_shell.dart';

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
        home: const RootShell(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
 
