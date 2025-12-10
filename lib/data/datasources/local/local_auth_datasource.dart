import 'dart:async';
import '../../../core/models/user.dart';

/// Локальный источник данных для авторизации (мок).
class LocalAuthDataSource {
  User? _currentUser;
  final _authController = StreamController<User?>.broadcast();

  /// Стрим состояния авторизации.
  Stream<User?> get authStream => _authController.stream;

  /// Текущий пользователь.
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  /// Вход (мок).
  Future<User> login(String email, String password) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Простая мок-авторизация
    if (password.length < 4) {
      throw Exception('Неверный пароль');
    }
    
    _currentUser = User(
      id: 'user_1',
      email: email,
      firstName: 'Иван',
      lastName: 'Иванов',
      middleName: 'Иванович',
      specialization: 'Терапевт',
      department: 'Терапевтическое отделение',
      phoneNumber: '+7-900-123-45-67',
      createdAt: DateTime.now(),
    );
    
    _authController.add(_currentUser);
    return _currentUser!;
  }

  /// Регистрация (мок).
  Future<User> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? specialization,
    String? department,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    _currentUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      specialization: specialization,
      department: department,
      createdAt: DateTime.now(),
    );
    
    _authController.add(_currentUser);
    return _currentUser!;
  }

  /// Выход.
  Future<void> logout() async {
    _currentUser = null;
    _authController.add(null);
  }

  /// Обновление профиля.
  Future<User> updateProfile(User user) async {
    _currentUser = user;
    _authController.add(_currentUser);
    return _currentUser!;
  }

  /// Проверка авторизации.
  Future<bool> isAuthenticated() async {
    return _currentUser != null;
  }

  void dispose() {
    _authController.close();
  }
}

