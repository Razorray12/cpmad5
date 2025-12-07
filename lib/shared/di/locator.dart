import 'package:get_it/get_it.dart';
import '../state/app_state.dart';
import '../../features/auth/state/auth_state.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  if (!getIt.isRegistered<AppState>()) {
    getIt.registerLazySingleton<AppState>(() => AppState());
  }
  if (!getIt.isRegistered<AuthState>()) {
    getIt.registerLazySingleton<AuthState>(() => AuthState());
  }
}


