import 'package:mobx/mobx.dart';
import '../models/user.dart';

part 'auth_state.g.dart';

/// MobX Store для авторизации.
///
/// Хранит текущего пользователя, статус авторизации.
class AuthState = _AuthState with _$AuthState;

abstract class _AuthState with Store {
  /// Текущий пользователь.
  @observable
  User? currentUser;

  /// Флаг загрузки.
  @observable
  bool isLoading = false;

  /// Сообщение об ошибке.
  @observable
  String? errorMessage;

  /// Авторизован ли пользователь.
  @computed
  bool get isAuthenticated => currentUser != null;

  /// Имитация входа в систему.
  @action
  Future<bool> login(String email, String password) async {
    isLoading = true;
    errorMessage = null;
    
    try {
      // Имитация задержки сети
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Простая валидация
      if (email.isEmpty || password.isEmpty) {
        errorMessage = 'Заполните все поля';
        isLoading = false;
        return false;
      }
      
      if (password.length < 6) {
        errorMessage = 'Пароль должен быть не менее 6 символов';
        isLoading = false;
        return false;
      }
      
      // Демо: любой email/password проходит
      currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        firstName: 'Алексей',
        lastName: 'Смирнов',
        middleName: 'Игоревич',
        specialization: 'Терапевт',
        department: 'Терапевтическое отделение',
        phoneNumber: '+7 (495) 123-45-67',
        avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
        createdAt: DateTime.now(),
      );
      
      isLoading = false;
      return true;
    } catch (e) {
      errorMessage = 'Ошибка входа: $e';
      isLoading = false;
      return false;
    }
  }

  /// Имитация регистрации.
  @action
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? specialization,
    String? department,
  }) async {
    isLoading = true;
    errorMessage = null;
    
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Валидация
      if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
        errorMessage = 'Заполните обязательные поля';
        isLoading = false;
        return false;
      }
      
      if (!email.contains('@')) {
        errorMessage = 'Введите корректный email';
        isLoading = false;
        return false;
      }
      
      if (password.length < 6) {
        errorMessage = 'Пароль должен быть не менее 6 символов';
        isLoading = false;
        return false;
      }
      
      // Создаём пользователя
      currentUser = User(
        id: 'user_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        specialization: specialization ?? 'Терапевт',
        department: department ?? 'Терапевтическое отделение',
        phoneNumber: null,
        avatarUrl: null,
        createdAt: DateTime.now(),
      );
      
      isLoading = false;
      return true;
    } catch (e) {
      errorMessage = 'Ошибка регистрации: $e';
      isLoading = false;
      return false;
    }
  }

  /// Выход из системы.
  @action
  void logout() {
    currentUser = null;
    errorMessage = null;
  }

  /// Обновление профиля пользователя.
  @action
  void updateProfile(User updatedUser) {
    currentUser = updatedUser;
  }

  /// Очистка ошибки.
  @action
  void clearError() {
    errorMessage = null;
  }
}

