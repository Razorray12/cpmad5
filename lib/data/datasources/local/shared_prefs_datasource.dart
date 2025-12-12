import 'package:shared_preferences/shared_preferences.dart';

/// Ключи для SharedPreferences.
class _PrefsKeys {
  static const String isDarkTheme = 'is_dark_theme';
}

/// DataSource для работы с SharedPreferences.
/// 
/// Используется для хранения настройки темы приложения (светлая/темная).
class SharedPrefsDataSource {
  SharedPreferences? _prefs;

  /// Получение экземпляра SharedPreferences.
  Future<SharedPreferences> _getPrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Сохранение настройки темы.
  Future<void> setDarkTheme(bool isDark) async {
    final prefs = await _getPrefs();
    await prefs.setBool(_PrefsKeys.isDarkTheme, isDark);
  }

  /// Получение настройки темы.
  Future<bool> isDarkTheme() async {
    final prefs = await _getPrefs();
    return prefs.getBool(_PrefsKeys.isDarkTheme) ?? false;
  }
}
