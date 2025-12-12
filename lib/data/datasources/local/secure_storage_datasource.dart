import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Ключи для SecureStorage.
class _SecureKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String userData = 'user_data';
  static const String tokenExpiry = 'token_expiry';
}

/// DataSource для безопасного хранения конфиденциальных данных.
/// 
/// Использует платформо-специфичные механизмы шифрования:
/// - Keychain на iOS
/// - KeyStore на Android
class SecureStorageDataSource {
  final FlutterSecureStorage _storage;

  SecureStorageDataSource()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock,
          ),
        );

  // ============================================
  // ТОКЕНЫ АВТОРИЗАЦИИ
  // ============================================

  /// Сохранение токена доступа.
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _SecureKeys.accessToken, value: token);
  }

  /// Получение токена доступа.
  Future<String?> getAccessToken() async {
    return await _storage.read(key: _SecureKeys.accessToken);
  }

  /// Сохранение refresh токена.
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _SecureKeys.refreshToken, value: token);
  }

  /// Получение refresh токена.
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: _SecureKeys.refreshToken);
  }

  /// Сохранение времени истечения токена.
  Future<void> saveTokenExpiry(DateTime expiry) async {
    await _storage.write(
      key: _SecureKeys.tokenExpiry,
      value: expiry.toIso8601String(),
    );
  }

  /// Получение времени истечения токена.
  Future<DateTime?> getTokenExpiry() async {
    final expiryString = await _storage.read(key: _SecureKeys.tokenExpiry);
    if (expiryString != null) {
      return DateTime.parse(expiryString);
    }
    return null;
  }

  /// Проверка действительности токена.
  Future<bool> isTokenValid() async {
    final expiry = await getTokenExpiry();
    if (expiry == null) return false;
    return expiry.isAfter(DateTime.now());
  }

  // ============================================
  // ДАННЫЕ ПОЛЬЗОВАТЕЛЯ
  // ============================================

  /// Сохранение ID пользователя.
  Future<void> saveUserId(String id) async {
    await _storage.write(key: _SecureKeys.userId, value: id);
  }

  /// Получение ID пользователя.
  Future<String?> getUserId() async {
    return await _storage.read(key: _SecureKeys.userId);
  }

  /// Сохранение email пользователя.
  Future<void> saveUserEmail(String email) async {
    await _storage.write(key: _SecureKeys.userEmail, value: email);
  }

  /// Получение email пользователя.
  Future<String?> getUserEmail() async {
    return await _storage.read(key: _SecureKeys.userEmail);
  }

  /// Сохранение данных пользователя как JSON.
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final jsonString = jsonEncode(userData);
    await _storage.write(key: _SecureKeys.userData, value: jsonString);
  }

  /// Получение данных пользователя.
  Future<Map<String, dynamic>?> getUserData() async {
    final jsonString = await _storage.read(key: _SecureKeys.userData);
    if (jsonString != null) {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    }
    return null;
  }

  // ============================================
  // УПРАВЛЕНИЕ СЕССИЕЙ
  // ============================================

  /// Сохранение всех данных авторизации.
  Future<void> saveAuthData({
    required String accessToken,
    String? refreshToken,
    required String userId,
    required String email,
    DateTime? tokenExpiry,
  }) async {
    await Future.wait([
      saveAccessToken(accessToken),
      if (refreshToken != null) saveRefreshToken(refreshToken),
      saveUserId(userId),
      saveUserEmail(email),
      if (tokenExpiry != null) saveTokenExpiry(tokenExpiry),
    ]);
  }

  /// Проверка авторизации пользователя.
  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    if (token == null) return false;
    
    final isValid = await isTokenValid();
    return isValid;
  }

  /// Очистка данных авторизации (выход).
  Future<void> clearAuthData() async {
    await Future.wait([
      _storage.delete(key: _SecureKeys.accessToken),
      _storage.delete(key: _SecureKeys.refreshToken),
      _storage.delete(key: _SecureKeys.userId),
      _storage.delete(key: _SecureKeys.userEmail),
      _storage.delete(key: _SecureKeys.userData),
      _storage.delete(key: _SecureKeys.tokenExpiry),
    ]);
  }

  /// Полная очистка хранилища.
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

