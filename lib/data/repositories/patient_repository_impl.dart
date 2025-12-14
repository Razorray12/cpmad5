import '../../core/models/patient.dart';
import '../../domain/repositories/patient_repository.dart';
import '../datasources/local/drift_datasource.dart';

/// Реализация репозитория пациентов.
/// 
/// Координирует работу с Drift базой данных.
class PatientRepositoryImpl implements PatientRepository {
  final DriftDataSource _driftDataSource;

  PatientRepositoryImpl(this._driftDataSource);

  @override
  Future<List<Patient>> getAllPatients() {
    return _driftDataSource.getAllPatients();
  }

  @override
  Future<Patient?> getPatientById(int id) {
    return _driftDataSource.getPatientById(id);
  }

  @override
  Future<Patient> addPatient(Patient patient) {
    return _driftDataSource.addPatient(patient);
  }

  @override
  Future<Patient> updatePatient(Patient patient) {
    return _driftDataSource.updatePatient(patient);
  }

  @override
  Future<void> deletePatient(int id) {
    return _driftDataSource.deletePatient(id);
  }

  @override
  Future<List<Patient>> searchPatients(String query) {
    return _driftDataSource.searchPatients(query);
  }

  @override
  Future<List<Patient>> getPatientsByStatus(PatientStatus status) {
    return _driftDataSource.getPatientsByStatus(status);
  }

  @override
  Future<int> getPatientCountByStatus(PatientStatus status) async {
    final patients = await _driftDataSource.getPatientsByStatus(status);
    return patients.length;
  }

  @override
  Stream<List<Patient>> watchPatients() {
    return _driftDataSource.watchAllPatients();
  }
}
