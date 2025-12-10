import '../../core/models/vital_sign.dart';

/// Абстрактный интерфейс репозитория показателей жизнедеятельности.
abstract class VitalRepository {
  /// Получить все показатели для пациента.
  Future<List<VitalSign>> getVitalsForPatient(int patientId);

  /// Получить последние показатели пациента.
  Future<VitalSign?> getLatestVitals(int patientId);

  /// Добавить показатели для пациента.
  Future<VitalSign> addVitals(VitalSign vitals);

  /// Обновить показатели.
  Future<VitalSign> updateVitals(VitalSign vitals);

  /// Удалить показатели.
  Future<void> deleteVitals(int id);

  /// Удалить все показатели пациента.
  Future<void> deleteAllVitalsForPatient(int patientId);

  /// Получить показатели за период.
  Future<List<VitalSign>> getVitalsForPeriod(
    int patientId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Стрим показателей пациента.
  Stream<List<VitalSign>> watchVitalsForPatient(int patientId);
}

