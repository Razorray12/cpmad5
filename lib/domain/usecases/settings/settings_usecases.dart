import '../../../data/datasources/local/shared_prefs_datasource.dart';

/// UseCase для получения текущей темы.
class GetThemeUseCase {
  final SharedPrefsDataSource _prefsDataSource;

  GetThemeUseCase(this._prefsDataSource);

  Future<bool> call() async {
    return await _prefsDataSource.isDarkTheme();
  }
}

/// UseCase для изменения темы.
class SetThemeUseCase {
  final SharedPrefsDataSource _prefsDataSource;

  SetThemeUseCase(this._prefsDataSource);

  Future<void> call(bool isDark) async {
    await _prefsDataSource.setDarkTheme(isDark);
  }
}
