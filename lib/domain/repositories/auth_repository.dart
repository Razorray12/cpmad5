import '../../core/models/user.dart';

/// Абстрактный интерфейс репозитория авторизации.
abstract class AuthRepository {
  /// Получить текущего пользователя.
  Future<User?> getCurrentUser();

  /// Войти в систему.
  Future<User> login(String email, String password);

  /// Зарегистрироваться.
  Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? specialization,
    String? department,
  });

  /// Выйти из системы.
  Future<void> logout();

  /// Обновить профиль пользователя.
  Future<User> updateProfile(User user);

  /// Изменить пароль.
  Future<void> changePassword(String oldPassword, String newPassword);

  /// Сбросить пароль.
  Future<void> resetPassword(String email);

  /// Проверить, авторизован ли пользователь.
  Future<bool> isAuthenticated();

  /// Стрим состояния авторизации.
  Stream<User?> watchAuthState();
}

