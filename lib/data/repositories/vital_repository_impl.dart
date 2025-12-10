import '../../core/models/vital_sign.dart';
import '../../domain/repositories/vital_repository.dart';
import '../datasources/local/local_vital_datasource.dart';

/// Реализация репозитория показателей жизнедеятельности.
class VitalRepositoryImpl implements VitalRepository {
  final LocalVitalDataSource _localDataSource;

  VitalRepositoryImpl(this._localDataSource);

  @override
  Future<List<VitalSign>> getVitalsForPatient(int patientId) {
    return _localDataSource.getForPatient(patientId);
  }

  @override
  Future<VitalSign?> getLatestVitals(int patientId) {
    return _localDataSource.getLatest(patientId);
  }

  @override
  Future<VitalSign> addVitals(VitalSign vitals) {
    return _localDataSource.add(vitals);
  }

  @override
  Future<VitalSign> updateVitals(VitalSign vitals) async {
    // Для in-memory реализации - удаляем старый и добавляем новый
    if (vitals.id != null) {
      await _localDataSource.delete(vitals.id!);
    }
    return _localDataSource.add(vitals);
  }

  @override
  Future<void> deleteVitals(int id) {
    return _localDataSource.delete(id);
  }

  @override
  Future<void> deleteAllVitalsForPatient(int patientId) {
    return _localDataSource.deleteAllForPatient(patientId);
  }

  @override
  Future<List<VitalSign>> getVitalsForPeriod(
    int patientId,
    DateTime startDate,
    DateTime endDate,
  ) {
    return _localDataSource.getForPeriod(patientId, startDate, endDate);
  }

  @override
  Stream<List<VitalSign>> watchVitalsForPatient(int patientId) {
    return _localDataSource.watchVitals(patientId);
  }
}

