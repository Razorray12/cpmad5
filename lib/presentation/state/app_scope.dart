import 'package:flutter/widgets.dart';
import 'app_state.dart';

/// Scope для предоставления AppState через InheritedWidget.
class AppScope extends InheritedWidget {
  final AppState store;

  const AppScope({
    super.key,
    required this.store,
    required super.child,
  });

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    if (scope == null) {
      throw FlutterError('AppScope not found in context');
    }
    return scope.store;
  }

  static AppState? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppScope>()?.store;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) => store != oldWidget.store;
}

