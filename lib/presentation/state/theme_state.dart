import 'package:mobx/mobx.dart';
import '../../domain/usecases/settings/settings_usecases.dart';

part 'theme_state.g.dart';

/// Состояние темы приложения.
class ThemeState = _ThemeState with _$ThemeState;

abstract class _ThemeState with Store {
  final GetThemeUseCase _getThemeUseCase;
  final SetThemeUseCase _setThemeUseCase;

  _ThemeState({
    required GetThemeUseCase getThemeUseCase,
    required SetThemeUseCase setThemeUseCase,
  })  : _getThemeUseCase = getThemeUseCase,
        _setThemeUseCase = setThemeUseCase;

  @observable
  bool isDarkTheme = false;

  @action
  Future<void> loadTheme() async {
    isDarkTheme = await _getThemeUseCase();
  }

  @action
  Future<void> toggleTheme() async {
    isDarkTheme = !isDarkTheme;
    await _setThemeUseCase(isDarkTheme);
  }

  @action
  Future<void> setTheme(bool isDark) async {
    isDarkTheme = isDark;
    await _setThemeUseCase(isDark);
  }
}

