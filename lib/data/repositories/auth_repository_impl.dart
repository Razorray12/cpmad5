import '../../core/models/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/local_auth_datasource.dart';

/// Реализация репозитория авторизации.
class AuthRepositoryImpl implements AuthRepository {
  final LocalAuthDataSource _localDataSource;

  AuthRepositoryImpl(this._localDataSource);

  @override
  Future<User?> getCurrentUser() {
    return _localDataSource.getCurrentUser();
  }

  @override
  Future<User> login(String email, String password) {
    return _localDataSource.login(email, password);
  }

  @override
  Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? specialization,
    String? department,
  }) {
    return _localDataSource.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      specialization: specialization,
      department: department,
    );
  }

  @override
  Future<void> logout() {
    return _localDataSource.logout();
  }

  @override
  Future<User> updateProfile(User user) {
    return _localDataSource.updateProfile(user);
  }

  @override
  Future<void> changePassword(String oldPassword, String newPassword) async {
    // Мок - просто проверяем длину
    if (newPassword.length < 6) {
      throw Exception('Пароль должен содержать минимум 6 символов');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    // Мок - имитируем отправку письма
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<bool> isAuthenticated() {
    return _localDataSource.isAuthenticated();
  }

  @override
  Stream<User?> watchAuthState() {
    return _localDataSource.authStream;
  }
}

