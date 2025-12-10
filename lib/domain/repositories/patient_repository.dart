import '../../core/models/patient.dart';

/// Абстрактный интерфейс репозитория пациентов.
/// 
/// Определяет контракт между бизнес-логикой и механизмами
/// доступа к данным без привязки к конкретным технологиям.
abstract class PatientRepository {
  /// Получить всех пациентов.
  Future<List<Patient>> getAllPatients();

  /// Получить пациента по ID.
  Future<Patient?> getPatientById(int id);

  /// Добавить нового пациента.
  Future<Patient> addPatient(Patient patient);

  /// Обновить данные пациента.
  Future<Patient> updatePatient(Patient patient);

  /// Удалить пациента.
  Future<void> deletePatient(int id);

  /// Поиск пациентов по запросу.
  Future<List<Patient>> searchPatients(String query);

  /// Получить пациентов по статусу.
  Future<List<Patient>> getPatientsByStatus(PatientStatus status);

  /// Получить количество пациентов по статусу.
  Future<int> getPatientCountByStatus(PatientStatus status);

  /// Стрим изменений списка пациентов.
  Stream<List<Patient>> watchPatients();
}

