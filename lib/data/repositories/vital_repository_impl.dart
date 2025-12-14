import '../../core/models/vital_sign.dart';
import '../../domain/repositories/vital_repository.dart';
import '../datasources/local/drift_datasource.dart';

/// Реализация репозитория показателей жизнедеятельности.
class VitalRepositoryImpl implements VitalRepository {
  final DriftDataSource _driftDataSource;

  VitalRepositoryImpl(this._driftDataSource);

  @override
  Future<List<VitalSign>> getVitalsForPatient(int patientId) {
    return _driftDataSource.getVitalsForPatient(patientId);
  }

  @override
  Future<VitalSign?> getLatestVitals(int patientId) {
    return _driftDataSource.getLatestVitals(patientId);
  }

  @override
  Future<VitalSign> addVitals(VitalSign vitals) {
    return _driftDataSource.addVitalSign(vitals);
  }

  @override
  Future<VitalSign> updateVitals(VitalSign vitals) async {
    // Для Drift - удаляем старый и добавляем новый
    if (vitals.id != null) {
      await _driftDataSource.deleteVitalSign(vitals.id!);
    }
    return _driftDataSource.addVitalSign(vitals);
  }

  @override
  Future<void> deleteVitals(int id) {
    return _driftDataSource.deleteVitalSign(id);
  }

  @override
  Future<void> deleteAllVitalsForPatient(int patientId) {
    return _driftDataSource.deleteVitalsForPatient(patientId);
  }

  @override
  Future<List<VitalSign>> getVitalsForPeriod(
    int patientId,
    DateTime startDate,
    DateTime endDate,
  ) {
    return _driftDataSource.getVitalsForPeriod(patientId, startDate, endDate);
  }

  @override
  Stream<List<VitalSign>> watchVitalsForPatient(int patientId) {
    return _driftDataSource.watchVitalsForPatient(patientId);
  }
}
