import 'package:get_it/get_it.dart';

// Data Sources
import '../../../data/datasources/local/local_patient_datasource.dart';
import '../../../data/datasources/local/local_vital_datasource.dart';
import '../../../data/datasources/local/local_consultation_datasource.dart';
import '../../../data/datasources/local/local_auth_datasource.dart';
import '../../../data/datasources/local/local_chat_datasource.dart';
import '../../../data/datasources/local/shared_prefs_datasource.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../data/datasources/local/drift_datasource.dart';

// Repositories
import '../../../data/repositories/patient_repository_impl.dart';
import '../../../data/repositories/vital_repository_impl.dart';
import '../../../data/repositories/consultation_repository_impl.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/repositories/chat_repository_impl.dart';

// Domain Repositories (interfaces)
import '../../../domain/repositories/patient_repository.dart';
import '../../../domain/repositories/vital_repository.dart';
import '../../../domain/repositories/consultation_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/chat_repository.dart';

// Use Cases
import '../../../domain/usecases/patient/get_patients_usecase.dart';
import '../../../domain/usecases/patient/manage_patient_usecase.dart';
import '../../../domain/usecases/vitals/vitals_usecases.dart';
import '../../../domain/usecases/consultation/consultation_usecases.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';
import '../../../domain/usecases/settings/settings_usecases.dart';

// State
import '../../../presentation/state/app_state.dart';
import '../../../presentation/state/theme_state.dart';
import '../../features/auth/state/auth_state.dart';

final GetIt getIt = GetIt.instance;

/// Настройка Dependency Injection.
/// 
/// Регистрирует все зависимости согласно Clean Architecture:
/// DataSources -> Repositories -> UseCases -> State
Future<void> setupLocator() async {
  // ============================================
  // LOCAL STORAGE DATA SOURCES (Singleton)
  // ============================================
  
  // SharedPreferences для хранения темы приложения
  if (!getIt.isRegistered<SharedPrefsDataSource>()) {
    getIt.registerLazySingleton<SharedPrefsDataSource>(
      () => SharedPrefsDataSource(),
    );
  }
  
  // Flutter Secure Storage для токенов авторизации
  if (!getIt.isRegistered<SecureStorageDataSource>()) {
    getIt.registerLazySingleton<SecureStorageDataSource>(
      () => SecureStorageDataSource(),
    );
  }
  
  // Drift (SQLite) для хранения данных пациентов
  if (!getIt.isRegistered<DriftDataSource>()) {
    final driftDataSource = DriftDataSource();
    await driftDataSource.init();
    getIt.registerLazySingleton<DriftDataSource>(
      () => driftDataSource,
    );
  }
  
  // ============================================
  // DATA SOURCES (Singleton)
  // ============================================
  
  if (!getIt.isRegistered<LocalPatientDataSource>()) {
    getIt.registerLazySingleton<LocalPatientDataSource>(
      () => LocalPatientDataSource(),
    );
  }
  
  if (!getIt.isRegistered<LocalVitalDataSource>()) {
    getIt.registerLazySingleton<LocalVitalDataSource>(
      () => LocalVitalDataSource(),
    );
  }
  
  if (!getIt.isRegistered<LocalConsultationDataSource>()) {
    getIt.registerLazySingleton<LocalConsultationDataSource>(
      () => LocalConsultationDataSource(),
    );
  }
  
  // LocalAuthDataSource использует SecureStorageDataSource
  if (!getIt.isRegistered<LocalAuthDataSource>()) {
    getIt.registerLazySingleton<LocalAuthDataSource>(
      () => LocalAuthDataSource(getIt<SecureStorageDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<LocalChatDataSource>()) {
    getIt.registerLazySingleton<LocalChatDataSource>(
      () => LocalChatDataSource(),
    );
  }

  // ============================================
  // REPOSITORIES (Singleton)
  // ============================================
  
  if (!getIt.isRegistered<PatientRepository>()) {
    getIt.registerLazySingleton<PatientRepository>(
      () => PatientRepositoryImpl(getIt<LocalPatientDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<VitalRepository>()) {
    getIt.registerLazySingleton<VitalRepository>(
      () => VitalRepositoryImpl(getIt<LocalVitalDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<ConsultationRepository>()) {
    getIt.registerLazySingleton<ConsultationRepository>(
      () => ConsultationRepositoryImpl(getIt<LocalConsultationDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<LocalAuthDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<ChatRepository>()) {
    getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(getIt<LocalChatDataSource>()),
    );
  }

  // ============================================
  // USE CASES (Factory - новый экземпляр при каждом запросе)
  // ============================================
  
  // Patient Use Cases
  if (!getIt.isRegistered<GetPatientsUseCase>()) {
    getIt.registerFactory<GetPatientsUseCase>(
      () => GetPatientsUseCase(getIt<PatientRepository>()),
    );
  }
  
  if (!getIt.isRegistered<GetPatientByIdUseCase>()) {
    getIt.registerFactory<GetPatientByIdUseCase>(
      () => GetPatientByIdUseCase(getIt<PatientRepository>()),
    );
  }
  
  if (!getIt.isRegistered<SearchPatientsUseCase>()) {
    getIt.registerFactory<SearchPatientsUseCase>(
      () => SearchPatientsUseCase(getIt<PatientRepository>()),
    );
  }
  
  if (!getIt.isRegistered<AddPatientUseCase>()) {
    getIt.registerFactory<AddPatientUseCase>(
      () => AddPatientUseCase(getIt<PatientRepository>()),
    );
  }
  
  if (!getIt.isRegistered<UpdatePatientUseCase>()) {
    getIt.registerFactory<UpdatePatientUseCase>(
      () => UpdatePatientUseCase(getIt<PatientRepository>()),
    );
  }
  
  if (!getIt.isRegistered<DeletePatientUseCase>()) {
    getIt.registerFactory<DeletePatientUseCase>(
      () => DeletePatientUseCase(
        getIt<PatientRepository>(),
        getIt<VitalRepository>(),
        getIt<ConsultationRepository>(),
      ),
    );
  }

  // Vitals Use Cases
  if (!getIt.isRegistered<GetVitalsUseCase>()) {
    getIt.registerFactory<GetVitalsUseCase>(
      () => GetVitalsUseCase(getIt<VitalRepository>()),
    );
  }
  
  if (!getIt.isRegistered<AddVitalsUseCase>()) {
    getIt.registerFactory<AddVitalsUseCase>(
      () => AddVitalsUseCase(getIt<VitalRepository>()),
    );
  }

  if (!getIt.isRegistered<DeleteVitalsUseCase>()) {
    getIt.registerFactory<DeleteVitalsUseCase>(
      () => DeleteVitalsUseCase(getIt<VitalRepository>()),
    );
  }

  if (!getIt.isRegistered<GetLatestVitalsUseCase>()) {
    getIt.registerFactory<GetLatestVitalsUseCase>(
      () => GetLatestVitalsUseCase(getIt<VitalRepository>()),
    );
  }

  // Consultation Use Cases
  if (!getIt.isRegistered<GetConsultationsUseCase>()) {
    getIt.registerFactory<GetConsultationsUseCase>(
      () => GetConsultationsUseCase(getIt<ConsultationRepository>()),
    );
  }
  
  if (!getIt.isRegistered<AddConsultationUseCase>()) {
    getIt.registerFactory<AddConsultationUseCase>(
      () => AddConsultationUseCase(getIt<ConsultationRepository>()),
    );
  }

  if (!getIt.isRegistered<UpdateConsultationUseCase>()) {
    getIt.registerFactory<UpdateConsultationUseCase>(
      () => UpdateConsultationUseCase(getIt<ConsultationRepository>()),
    );
  }

  if (!getIt.isRegistered<DeleteConsultationUseCase>()) {
    getIt.registerFactory<DeleteConsultationUseCase>(
      () => DeleteConsultationUseCase(getIt<ConsultationRepository>()),
    );
  }

  // Auth Use Cases
  if (!getIt.isRegistered<LoginUseCase>()) {
    getIt.registerFactory<LoginUseCase>(
      () => LoginUseCase(getIt<AuthRepository>()),
    );
  }
  
  if (!getIt.isRegistered<RegisterUseCase>()) {
    getIt.registerFactory<RegisterUseCase>(
      () => RegisterUseCase(getIt<AuthRepository>()),
    );
  }
  
  if (!getIt.isRegistered<GetCurrentUserUseCase>()) {
    getIt.registerFactory<GetCurrentUserUseCase>(
      () => GetCurrentUserUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<LogoutUseCase>()) {
    getIt.registerFactory<LogoutUseCase>(
      () => LogoutUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<UpdateProfileUseCase>()) {
    getIt.registerFactory<UpdateProfileUseCase>(
      () => UpdateProfileUseCase(getIt<AuthRepository>()),
    );
  }

  if (!getIt.isRegistered<CheckAuthUseCase>()) {
    getIt.registerFactory<CheckAuthUseCase>(
      () => CheckAuthUseCase(getIt<AuthRepository>()),
    );
  }

  // Theme Use Cases (SharedPreferences)
  if (!getIt.isRegistered<GetThemeUseCase>()) {
    getIt.registerFactory<GetThemeUseCase>(
      () => GetThemeUseCase(getIt<SharedPrefsDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<SetThemeUseCase>()) {
    getIt.registerFactory<SetThemeUseCase>(
      () => SetThemeUseCase(getIt<SharedPrefsDataSource>()),
    );
  }

  // ============================================
  // STATE (Singleton)
  // ============================================
  
  // ThemeState для управления темой
  if (!getIt.isRegistered<ThemeState>()) {
    final themeState = ThemeState(
      getThemeUseCase: getIt<GetThemeUseCase>(),
      setThemeUseCase: getIt<SetThemeUseCase>(),
    );
    await themeState.loadTheme();
    getIt.registerLazySingleton<ThemeState>(() => themeState);
  }
  
  if (!getIt.isRegistered<AppState>()) {
    getIt.registerLazySingleton<AppState>(
      () => AppState(
        getPatientsUseCase: getIt<GetPatientsUseCase>(),
        searchPatientsUseCase: getIt<SearchPatientsUseCase>(),
        addPatientUseCase: getIt<AddPatientUseCase>(),
        updatePatientUseCase: getIt<UpdatePatientUseCase>(),
        deletePatientUseCase: getIt<DeletePatientUseCase>(),
        getVitalsUseCase: getIt<GetVitalsUseCase>(),
        getLatestVitalsUseCase: getIt<GetLatestVitalsUseCase>(),
        addVitalsUseCase: getIt<AddVitalsUseCase>(),
        deleteVitalsUseCase: getIt<DeleteVitalsUseCase>(),
        getConsultationsUseCase: getIt<GetConsultationsUseCase>(),
        addConsultationUseCase: getIt<AddConsultationUseCase>(),
        updateConsultationUseCase: getIt<UpdateConsultationUseCase>(),
        deleteConsultationUseCase: getIt<DeleteConsultationUseCase>(),
      ),
    );
  }
  
  if (!getIt.isRegistered<AuthState>()) {
    getIt.registerLazySingleton<AuthState>(
      () => AuthState(
        loginUseCase: getIt<LoginUseCase>(),
        registerUseCase: getIt<RegisterUseCase>(),
        logoutUseCase: getIt<LogoutUseCase>(),
        getCurrentUserUseCase: getIt<GetCurrentUserUseCase>(),
        updateProfileUseCase: getIt<UpdateProfileUseCase>(),
        checkAuthUseCase: getIt<CheckAuthUseCase>(),
      ),
    );
  }

  // ============================================
  // INITIALIZE SAMPLE DATA
  // ============================================
  
  // Инициализируем тестовые данные
  await getIt<LocalPatientDataSource>().initializeSampleData();
  
  // Загружаем данные в состояние
  await getIt<AppState>().loadData();
}
