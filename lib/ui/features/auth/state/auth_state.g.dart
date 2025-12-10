// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthState on _AuthState, Store {
  Computed<bool>? _$isAuthenticatedComputed;

  @override
  bool get isAuthenticated => (_$isAuthenticatedComputed ??= Computed<bool>(
    () => super.isAuthenticated,
    name: '_AuthState.isAuthenticated',
  )).value;

  late final _$currentUserAtom = Atom(
    name: '_AuthState.currentUser',
    context: context,
  );

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AuthState.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_AuthState.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$loginAsyncAction = AsyncAction(
    '_AuthState.login',
    context: context,
  );

  @override
  Future<bool> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  late final _$registerAsyncAction = AsyncAction(
    '_AuthState.register',
    context: context,
  );

  @override
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    String? middleName,
    String? specialization,
    String? department,
  }) {
    return _$registerAsyncAction.run(
      () => super.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        middleName: middleName,
        specialization: specialization,
        department: department,
      ),
    );
  }

  late final _$logoutAsyncAction = AsyncAction(
    '_AuthState.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$loadCurrentUserAsyncAction = AsyncAction(
    '_AuthState.loadCurrentUser',
    context: context,
  );

  @override
  Future<void> loadCurrentUser() {
    return _$loadCurrentUserAsyncAction.run(() => super.loadCurrentUser());
  }

  late final _$checkAuthStatusAsyncAction = AsyncAction(
    '_AuthState.checkAuthStatus',
    context: context,
  );

  @override
  Future<bool> checkAuthStatus() {
    return _$checkAuthStatusAsyncAction.run(() => super.checkAuthStatus());
  }

  late final _$updateProfileAsyncAction = AsyncAction(
    '_AuthState.updateProfile',
    context: context,
  );

  @override
  Future<void> updateProfile(User updatedUser) {
    return _$updateProfileAsyncAction.run(
      () => super.updateProfile(updatedUser),
    );
  }

  late final _$_AuthStateActionController = ActionController(
    name: '_AuthState',
    context: context,
  );

  @override
  void clearError() {
    final _$actionInfo = _$_AuthStateActionController.startAction(
      name: '_AuthState.clearError',
    );
    try {
      return super.clearError();
    } finally {
      _$_AuthStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentUser: ${currentUser},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
isAuthenticated: ${isAuthenticated}
    ''';
  }
}
