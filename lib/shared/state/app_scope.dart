import 'package:flutter/widgets.dart';
import 'app_state.dart';

/// Простая обертка над [AppState] для доступа через контекст.
///
/// Реактивность обеспечивает MobX через [Observer], а не сам InheritedWidget.
class AppScope extends InheritedWidget {
  final AppState store;

  const AppScope({
    super.key,
    required this.store,
    required Widget child,
  }) : super(child: child);

  static AppState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in context');
    return scope!.store;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) {
    // Храним один и тот же singleton Store, поэтому тут всегда false.
    return false;
  }
}
