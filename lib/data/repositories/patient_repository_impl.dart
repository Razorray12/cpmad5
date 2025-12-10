import '../../core/models/patient.dart';
import '../../domain/repositories/patient_repository.dart';
import '../datasources/local/local_patient_datasource.dart';

/// Реализация репозитория пациентов.
/// 
/// Координирует работу с источниками данных и реализует
/// стратегии доступа к данным (кэширование, синхронизация).
class PatientRepositoryImpl implements PatientRepository {
  final LocalPatientDataSource _localDataSource;
  // Можно добавить RemotePatientDataSource для работы с API

  PatientRepositoryImpl(this._localDataSource);

  @override
  Future<List<Patient>> getAllPatients() {
    return _localDataSource.getAll();
  }

  @override
  Future<Patient?> getPatientById(int id) {
    return _localDataSource.getById(id);
  }

  @override
  Future<Patient> addPatient(Patient patient) {
    return _localDataSource.add(patient);
  }

  @override
  Future<Patient> updatePatient(Patient patient) {
    return _localDataSource.update(patient);
  }

  @override
  Future<void> deletePatient(int id) {
    return _localDataSource.delete(id);
  }

  @override
  Future<List<Patient>> searchPatients(String query) {
    return _localDataSource.search(query);
  }

  @override
  Future<List<Patient>> getPatientsByStatus(PatientStatus status) {
    return _localDataSource.getByStatus(status);
  }

  @override
  Future<int> getPatientCountByStatus(PatientStatus status) async {
    final patients = await _localDataSource.getByStatus(status);
    return patients.length;
  }

  @override
  Stream<List<Patient>> watchPatients() {
    return _localDataSource.patientsStream;
  }

  /// Инициализация тестовых данных.
  Future<void> initializeSampleData() {
    return _localDataSource.initializeSampleData();
  }
}

