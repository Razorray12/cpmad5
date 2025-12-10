import 'package:mobx/mobx.dart';
import '../../../../core/models/user.dart';
import '../../../../domain/usecases/auth/auth_usecases.dart';

part 'auth_state.g.dart';

/// MobX Store для авторизации.
///
/// Хранит текущего пользователя, статус авторизации.
class AuthState = _AuthState with _$AuthState;

abstract class _AuthState with Store {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final CheckAuthUseCase checkAuthUseCase;

  _AuthState({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.updateProfileUseCase,
    required this.checkAuthUseCase,
  });

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
      currentUser = await loginUseCase.execute(email, password);
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
      currentUser = await registerUseCase.execute(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        specialization: specialization,
        department: department,
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
  Future<void> logout() async {
    await logoutUseCase.execute();
    currentUser = null;
    errorMessage = null;
  }

  /// Получить текущего пользователя из хранилища.
  @action
  Future<void> loadCurrentUser() async {
    currentUser = await getCurrentUserUseCase.execute();
  }

  /// Проверить актуальный статус авторизации.
  @action
  Future<bool> checkAuthStatus() async {
    final isAuth = await checkAuthUseCase.execute();
    if (!isAuth) {
      currentUser = null;
    }
    return isAuth;
  }

  /// Обновление профиля пользователя.
  @action
  Future<void> updateProfile(User updatedUser) async {
    currentUser = await updateProfileUseCase.execute(updatedUser);
  }

  /// Очистка ошибки.
  @action
  void clearError() {
    errorMessage = null;
  }
}

