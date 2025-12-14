import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

// Data Sources - Local
import '../../../data/datasources/local/local_auth_datasource.dart';
import '../../../data/datasources/local/local_chat_datasource.dart';
import '../../../data/datasources/local/shared_prefs_datasource.dart';
import '../../../data/datasources/local/secure_storage_datasource.dart';
import '../../../data/datasources/local/drift_datasource.dart';

// Data Sources - Remote
import '../../../data/datasources/remote/dio_client.dart';
import '../../../data/datasources/remote/api/disease_api.dart';
import '../../../data/datasources/remote/api/drug_api.dart';
import '../../../data/datasources/remote/api/fda_api.dart';
import '../../../data/datasources/remote/remote_covid_datasource.dart';
import '../../../data/datasources/remote/remote_drug_datasource.dart';
import '../../../data/datasources/remote/remote_fda_datasource.dart';

// Repositories
import '../../../data/repositories/patient_repository_impl.dart';
import '../../../data/repositories/vital_repository_impl.dart';
import '../../../data/repositories/consultation_repository_impl.dart';
import '../../../data/repositories/auth_repository_impl.dart';
import '../../../data/repositories/chat_repository_impl.dart';
import '../../../data/repositories/medical_info_repository_impl.dart';

// Domain Repositories (interfaces)
import '../../../domain/repositories/patient_repository.dart';
import '../../../domain/repositories/vital_repository.dart';
import '../../../domain/repositories/consultation_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/repositories/chat_repository.dart';
import '../../../domain/repositories/medical_info_repository.dart';

// Use Cases
import '../../../domain/usecases/patient/get_patients_usecase.dart';
import '../../../domain/usecases/patient/manage_patient_usecase.dart';
import '../../../domain/usecases/vitals/vitals_usecases.dart';
import '../../../domain/usecases/consultation/consultation_usecases.dart';
import '../../../domain/usecases/auth/auth_usecases.dart';
import '../../../domain/usecases/settings/settings_usecases.dart';
import '../../../domain/usecases/medical/medical_usecases.dart';

// State
import '../../../presentation/state/app_state.dart';
import '../../../presentation/state/theme_state.dart';
import '../../features/auth/state/auth_state.dart';
import '../../features/medical/state/medical_state.dart';

// Models for sample data
import '../../../core/models/patient.dart';

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
  
  // Drift (SQLite/IndexedDB) для хранения данных пациентов, показателей, консультаций
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
  // REMOTE DATA SOURCES (Singleton)
  // ============================================

  // Dio клиенты для различных API
  if (!getIt.isRegistered<Dio>(instanceName: 'diseaseApi')) {
    getIt.registerLazySingleton<Dio>(
      () => DioClient.createDiseaseApiClient(),
      instanceName: 'diseaseApi',
    );
  }

  if (!getIt.isRegistered<Dio>(instanceName: 'drugApi')) {
    getIt.registerLazySingleton<Dio>(
      () => DioClient.createDrugApiClient(),
      instanceName: 'drugApi',
    );
  }

  if (!getIt.isRegistered<Dio>(instanceName: 'fdaApi')) {
    getIt.registerLazySingleton<Dio>(
      () => DioClient.createFdaApiClient(),
      instanceName: 'fdaApi',
    );
  }

  // Retrofit API клиенты
  if (!getIt.isRegistered<DiseaseApi>()) {
    getIt.registerLazySingleton<DiseaseApi>(
      () => DiseaseApi(getIt<Dio>(instanceName: 'diseaseApi')),
    );
  }

  if (!getIt.isRegistered<DrugApi>()) {
    getIt.registerLazySingleton<DrugApi>(
      () => DrugApi(getIt<Dio>(instanceName: 'drugApi')),
    );
  }

  if (!getIt.isRegistered<FdaApi>()) {
    getIt.registerLazySingleton<FdaApi>(
      () => FdaApi(getIt<Dio>(instanceName: 'fdaApi')),
    );
  }

  // Remote DataSources
  if (!getIt.isRegistered<RemoteCovidDataSource>()) {
    getIt.registerLazySingleton<RemoteCovidDataSource>(
      () => RemoteCovidDataSource(getIt<DiseaseApi>()),
    );
  }

  if (!getIt.isRegistered<RemoteDrugDataSource>()) {
    getIt.registerLazySingleton<RemoteDrugDataSource>(
      () => RemoteDrugDataSource(getIt<DrugApi>()),
    );
  }

  if (!getIt.isRegistered<RemoteFdaDataSource>()) {
    getIt.registerLazySingleton<RemoteFdaDataSource>(
      () => RemoteFdaDataSource(getIt<FdaApi>()),
    );
  }

  // ============================================
  // REPOSITORIES (Singleton)
  // ============================================
  
  // Все репозитории используют DriftDataSource для локального хранения
  if (!getIt.isRegistered<PatientRepository>()) {
    getIt.registerLazySingleton<PatientRepository>(
      () => PatientRepositoryImpl(getIt<DriftDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<VitalRepository>()) {
    getIt.registerLazySingleton<VitalRepository>(
      () => VitalRepositoryImpl(getIt<DriftDataSource>()),
    );
  }
  
  if (!getIt.isRegistered<ConsultationRepository>()) {
    getIt.registerLazySingleton<ConsultationRepository>(
      () => ConsultationRepositoryImpl(getIt<DriftDataSource>()),
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

  // Medical Info Repository (использует remote data sources)
  if (!getIt.isRegistered<MedicalInfoRepository>()) {
    getIt.registerLazySingleton<MedicalInfoRepository>(
      () => MedicalInfoRepositoryImpl(
        getIt<RemoteCovidDataSource>(),
        getIt<RemoteDrugDataSource>(),
      ),
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

  // Medical Use Cases (COVID-19 + Drugs)
  if (!getIt.isRegistered<GetGlobalCovidStatsUseCase>()) {
    getIt.registerFactory<GetGlobalCovidStatsUseCase>(
      () => GetGlobalCovidStatsUseCase(getIt<MedicalInfoRepository>()),
    );
  }

  if (!getIt.isRegistered<GetCountryCovidStatsUseCase>()) {
    getIt.registerFactory<GetCountryCovidStatsUseCase>(
      () => GetCountryCovidStatsUseCase(getIt<MedicalInfoRepository>()),
    );
  }

  if (!getIt.isRegistered<GetAllCountriesCovidStatsUseCase>()) {
    getIt.registerFactory<GetAllCountriesCovidStatsUseCase>(
      () => GetAllCountriesCovidStatsUseCase(getIt<MedicalInfoRepository>()),
    );
  }

  if (!getIt.isRegistered<GetCovidHistoricalUseCase>()) {
    getIt.registerFactory<GetCovidHistoricalUseCase>(
      () => GetCovidHistoricalUseCase(getIt<MedicalInfoRepository>()),
    );
  }

  if (!getIt.isRegistered<SearchDrugsUseCase>()) {
    getIt.registerFactory<SearchDrugsUseCase>(
      () => SearchDrugsUseCase(getIt<MedicalInfoRepository>()),
    );
  }

  if (!getIt.isRegistered<GetDrugAdverseEventsUseCase>()) {
    getIt.registerFactory<GetDrugAdverseEventsUseCase>(
      () => GetDrugAdverseEventsUseCase(getIt<MedicalInfoRepository>()),
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

  // MedicalState для работы с медицинской информацией из API
  if (!getIt.isRegistered<MedicalState>()) {
    getIt.registerLazySingleton<MedicalState>(
      () => MedicalState(
        getGlobalCovidStatsUseCase: getIt<GetGlobalCovidStatsUseCase>(),
        getCountryCovidStatsUseCase: getIt<GetCountryCovidStatsUseCase>(),
        getAllCountriesCovidStatsUseCase: getIt<GetAllCountriesCovidStatsUseCase>(),
        getCovidHistoricalUseCase: getIt<GetCovidHistoricalUseCase>(),
        searchDrugsUseCase: getIt<SearchDrugsUseCase>(),
        getDrugAdverseEventsUseCase: getIt<GetDrugAdverseEventsUseCase>(),
      ),
    );
  }

  // ============================================
  // INITIALIZE SAMPLE DATA IN DRIFT
  // ============================================
  
  // Проверяем, есть ли уже данные в базе
  final driftDataSource = getIt<DriftDataSource>();
  final existingPatients = await driftDataSource.getAllPatients();
  
  if (existingPatients.isEmpty) {
    // Инициализируем тестовые данные только если база пустая
    // ignore: avoid_print
    print('setupLocator: Initializing sample data...');
    await _initializeSampleData(driftDataSource);
  }
  
  // Загружаем данные в состояние
  await getIt<AppState>().loadData();
}

/// Инициализация тестовых данных в Drift базе данных.
Future<void> _initializeSampleData(DriftDataSource dataSource) async {
  final samplePatients = [
    Patient(
      id: 0,
      firstName: 'Анна',
      lastName: 'Петрова',
      middleName: 'Сергеевна',
      birthDate: '1985-03-15',
      phoneNumber: '+7-912-345-67-89',
      diagnosis: 'Гипертоническая болезнь II степени',
      room: '101',
      sex: 'Женский',
      admissionDate: '2024-01-15',
      medications: 'Эналаприл 5мг, Амлодипин 5мг',
      allergies: 'Пенициллин',
      mainDoctor: 'Иванов И.И.',
      mainDoctorID: 'DOC001',
      status: PatientStatus.stable,
      imageUrl: 'https://randomuser.me/api/portraits/men/30.jpg',
    ),
    Patient(
      id: 0,
      firstName: 'Михаил',
      lastName: 'Сидоров',
      middleName: 'Александрович',
      birthDate: '1978-07-22',
      phoneNumber: '+7-923-456-78-90',
      diagnosis: 'Сахарный диабет 2 типа',
      room: '205',
      sex: 'Мужской',
      admissionDate: '2024-01-20',
      medications: 'Метформин 1000мг, Глибенкламид 5мг',
      allergies: 'Сульфаниламиды',
      mainDoctor: 'Петрова А.А.',
      mainDoctorID: 'DOC002',
      status: PatientStatus.observation,
      imageUrl: 'https://randomuser.me/api/portraits/women/51.jpg',
    ),
    Patient(
      id: 0,
      firstName: 'Елена',
      lastName: 'Козлова',
      middleName: 'Владимировна',
      birthDate: '1992-11-08',
      phoneNumber: '+7-934-567-89-01',
      diagnosis: 'Бронхиальная астма',
      room: '312',
      sex: 'Женский',
      admissionDate: '2024-01-25',
      medications: 'Сальбутамол, Беклометазон',
      allergies: 'Пыльца растений',
      mainDoctor: 'Смирнов В.В.',
      mainDoctorID: 'DOC003',
      status: PatientStatus.observation,
      imageUrl: 'https://randomuser.me/api/portraits/women/92.jpg',
    ),
    Patient(
      id: 0,
      firstName: 'Дмитрий',
      lastName: 'Морозов',
      middleName: 'Игоревич',
      birthDate: '1980-05-14',
      phoneNumber: '+7-945-678-90-12',
      diagnosis: 'Ишемическая болезнь сердца',
      room: '108',
      sex: 'Мужской',
      admissionDate: '2024-01-28',
      medications: 'Аспирин 75мг, Аторвастатин 20мг',
      allergies: 'Нет',
      mainDoctor: 'Кузнецова Н.Н.',
      mainDoctorID: 'DOC004',
      status: PatientStatus.stable,
      imageUrl: 'https://randomuser.me/api/portraits/men/57.jpg',
    ),
    Patient(
      id: 0,
      firstName: 'Ольга',
      lastName: 'Новикова',
      middleName: 'Петровна',
      birthDate: '1975-12-03',
      phoneNumber: '+7-956-789-01-23',
      diagnosis: 'Хронический гастрит',
      room: '401',
      sex: 'Женский',
      admissionDate: '2024-02-01',
      medications: 'Омепразол 20мг, Домперидон 10мг',
      allergies: 'Лактоза',
      mainDoctor: 'Волкова С.С.',
      mainDoctorID: 'DOC005',
      status: PatientStatus.observation,
      imageUrl: 'https://randomuser.me/api/portraits/women/77.jpg',
    ),
  ];

  for (final patient in samplePatients) {
    await dataSource.addPatient(patient);
  }
}
