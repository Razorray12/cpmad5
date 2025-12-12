import 'dart:async';
import 'dart:convert';
import '../../../core/models/user.dart';
import 'secure_storage_datasource.dart';

/// Локальный источник данных для авторизации.
/// 
/// Использует SecureStorageDataSource для безопасного хранения
/// токенов и данных авторизации.
class LocalAuthDataSource {
  final SecureStorageDataSource _secureStorage;
  User? _currentUser;
  final _authController = StreamController<User?>.broadcast();

  LocalAuthDataSource(this._secureStorage);

  /// Стрим состояния авторизации.
  Stream<User?> get authStream => _authController.stream;

  /// Текущий пользователь.
  Future<User?> getCurrentUser() async {
    if (_currentUser != null) {
      return _currentUser;
    }
    
    // Попробуем восстановить сессию из SecureStorage
    final userData = await _secureStorage.getUserData();
    if (userData != null) {
      _currentUser = _userFromJson(userData);
      _authController.add(_currentUser);
    }
    
    return _currentUser;
  }

  /// Вход с использованием SecureStorage для хранения токенов.
  Future<User> login(String email, String password) async {
    // Имитация задержки сети
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Простая мок-авторизация
    if (password.length < 4) {
      throw Exception('Неверный пароль');
    }
    
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    
    _currentUser = User(
      id: userId,
      email: email,
      firstName: 'Иван',
      lastName: 'Иванов',
      middleName: 'Иванович',
      specialization: 'Терапевт',
      department: 'Терапевтическое отделение',
      phoneNumber: '+7-900-123-45-67',
      createdAt: DateTime.now(),
    );
    
    // Сохраняем данные авторизации в SecureStorage
    final mockAccessToken = 'access_token_${DateTime.now().millisecondsSinceEpoch}';
    final mockRefreshToken = 'refresh_token_${DateTime.now().millisecondsSinceEpoch}';
    final tokenExpiry = DateTime.now().add(const Duration(days: 7));
    
    await _secureStorage.saveAuthData(
      accessToken: mockAccessToken,
      refreshToken: mockRefreshToken,
      userId: userId,
      email: email,
      tokenExpiry: tokenExpiry,
    );
    
    // Сохраняем данные пользователя
    await _secureStorage.saveUserData(_userToJson(_currentUser!));
    
    _authController.add(_currentUser);
    return _currentUser!;
  }

  /// Регистрация с использованием SecureStorage.
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
    
    final userId = 'user_${DateTime.now().millisecondsSinceEpoch}';
    
    _currentUser = User(
      id: userId,
      email: email,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      specialization: specialization,
      department: department,
      createdAt: DateTime.now(),
    );
    
    // Сохраняем данные авторизации в SecureStorage
    final mockAccessToken = 'access_token_${DateTime.now().millisecondsSinceEpoch}';
    final mockRefreshToken = 'refresh_token_${DateTime.now().millisecondsSinceEpoch}';
    final tokenExpiry = DateTime.now().add(const Duration(days: 7));
    
    await _secureStorage.saveAuthData(
      accessToken: mockAccessToken,
      refreshToken: mockRefreshToken,
      userId: userId,
      email: email,
      tokenExpiry: tokenExpiry,
    );
    
    // Сохраняем данные пользователя
    await _secureStorage.saveUserData(_userToJson(_currentUser!));
    
    _authController.add(_currentUser);
    return _currentUser!;
  }

  /// Выход с очисткой SecureStorage.
  Future<void> logout() async {
    _currentUser = null;
    
    // Очищаем данные авторизации из SecureStorage
    await _secureStorage.clearAuthData();
    
    _authController.add(null);
  }

  /// Обновление профиля.
  Future<User> updateProfile(User user) async {
    _currentUser = user;
    
    // Обновляем данные пользователя в SecureStorage
    await _secureStorage.saveUserData(_userToJson(_currentUser!));
    
    _authController.add(_currentUser);
    return _currentUser!;
  }

  /// Проверка авторизации с использованием SecureStorage.
  Future<bool> isAuthenticated() async {
    // Проверяем наличие и валидность токена в SecureStorage
    final isValid = await _secureStorage.isAuthenticated();
    if (isValid) {
      // Восстанавливаем пользователя, если токен валиден
      await getCurrentUser();
    }
    return isValid;
  }

  /// Получить текущий токен доступа.
  Future<String?> getAccessToken() async {
    return await _secureStorage.getAccessToken();
  }

  /// Преобразование User в Map для хранения.
  Map<String, dynamic> _userToJson(User user) {
    return {
      'id': user.id,
      'email': user.email,
      'firstName': user.firstName,
      'lastName': user.lastName,
      'middleName': user.middleName,
      'specialization': user.specialization,
      'department': user.department,
      'phoneNumber': user.phoneNumber,
      'avatarUrl': user.avatarUrl,
      'createdAt': user.createdAt?.toIso8601String(),
    };
  }

  /// Преобразование Map в User.
  User _userFromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String?,
      specialization: json['specialization'] as String?,
      department: json['department'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
    );
  }

  void dispose() {
    _authController.close();
  }
}
