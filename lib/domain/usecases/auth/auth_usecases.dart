import '../../../core/models/user.dart';
import '../../repositories/auth_repository.dart';

/// Use Case для входа в систему.
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<User> execute(String email, String password) {
    // Валидация входных данных
    if (email.isEmpty) {
      throw ArgumentError('Email не может быть пустым');
    }
    if (password.isEmpty) {
      throw ArgumentError('Пароль не может быть пустым');
    }
    if (!_isValidEmail(email)) {
      throw ArgumentError('Неверный формат email');
    }

    return _repository.login(email, password);
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

/// Use Case для регистрации.
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<User> execute({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? specialization,
    String? department,
  }) {
    // Валидация
    if (email.isEmpty || password.isEmpty) {
      throw ArgumentError('Email и пароль обязательны');
    }
    if (firstName.isEmpty || lastName.isEmpty) {
      throw ArgumentError('Имя и фамилия обязательны');
    }
    if (password.length < 6) {
      throw ArgumentError('Пароль должен содержать минимум 6 символов');
    }

    return _repository.register(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      specialization: specialization,
      department: department,
    );
  }
}

/// Use Case для выхода из системы.
class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(this._repository);

  Future<void> execute() {
    return _repository.logout();
  }
}

/// Use Case для получения текущего пользователя.
class GetCurrentUserUseCase {
  final AuthRepository _repository;

  GetCurrentUserUseCase(this._repository);

  Future<User?> execute() {
    return _repository.getCurrentUser();
  }

  Stream<User?> watch() {
    return _repository.watchAuthState();
  }
}

/// Use Case для обновления профиля.
class UpdateProfileUseCase {
  final AuthRepository _repository;

  UpdateProfileUseCase(this._repository);

  Future<User> execute(User user) {
    return _repository.updateProfile(user);
  }
}

/// Use Case для проверки авторизации.
class CheckAuthUseCase {
  final AuthRepository _repository;

  CheckAuthUseCase(this._repository);

  Future<bool> execute() {
    return _repository.isAuthenticated();
  }
}

