// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ThemeState on _ThemeState, Store {
  late final _$isDarkThemeAtom = Atom(
    name: '_ThemeState.isDarkTheme',
    context: context,
  );

  @override
  bool get isDarkTheme {
    _$isDarkThemeAtom.reportRead();
    return super.isDarkTheme;
  }

  @override
  set isDarkTheme(bool value) {
    _$isDarkThemeAtom.reportWrite(value, super.isDarkTheme, () {
      super.isDarkTheme = value;
    });
  }

  late final _$loadThemeAsyncAction = AsyncAction(
    '_ThemeState.loadTheme',
    context: context,
  );

  @override
  Future<void> loadTheme() {
    return _$loadThemeAsyncAction.run(() => super.loadTheme());
  }

  late final _$toggleThemeAsyncAction = AsyncAction(
    '_ThemeState.toggleTheme',
    context: context,
  );

  @override
  Future<void> toggleTheme() {
    return _$toggleThemeAsyncAction.run(() => super.toggleTheme());
  }

  late final _$setThemeAsyncAction = AsyncAction(
    '_ThemeState.setTheme',
    context: context,
  );

  @override
  Future<void> setTheme(bool isDark) {
    return _$setThemeAsyncAction.run(() => super.setTheme(isDark));
  }

  @override
  String toString() {
    return '''
isDarkTheme: ${isDarkTheme}
    ''';
  }
}
