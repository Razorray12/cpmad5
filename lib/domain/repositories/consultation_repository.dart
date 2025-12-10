import '../../core/models/consultation.dart';

/// Абстрактный интерфейс репозитория консультаций.
abstract class ConsultationRepository {
  /// Получить все консультации.
  Future<List<Consultation>> getAllConsultations();

  /// Получить консультации для пациента.
  Future<List<Consultation>> getConsultationsForPatient(int patientId);

  /// Получить консультацию по ID.
  Future<Consultation?> getConsultationById(int id);

  /// Добавить консультацию.
  Future<Consultation> addConsultation(Consultation consultation);

  /// Обновить консультацию.
  Future<Consultation> updateConsultation(Consultation consultation);

  /// Удалить консультацию.
  Future<void> deleteConsultation(int id);

  /// Удалить все консультации пациента.
  Future<void> deleteAllConsultationsForPatient(int patientId);

  /// Получить консультации за период.
  Future<List<Consultation>> getConsultationsForPeriod(
    DateTime startDate,
    DateTime endDate,
  );

  /// Получить сегодняшние консультации.
  Future<List<Consultation>> getTodayConsultations();

  /// Стрим всех консультаций.
  Stream<List<Consultation>> watchConsultations();

  /// Стрим консультаций пациента.
  Stream<List<Consultation>> watchConsultationsForPatient(int patientId);
}

