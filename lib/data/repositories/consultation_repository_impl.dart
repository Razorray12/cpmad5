import '../../core/models/consultation.dart';
import '../../domain/repositories/consultation_repository.dart';
import '../datasources/local/local_consultation_datasource.dart';

/// Реализация репозитория консультаций.
class ConsultationRepositoryImpl implements ConsultationRepository {
  final LocalConsultationDataSource _localDataSource;

  ConsultationRepositoryImpl(this._localDataSource);

  @override
  Future<List<Consultation>> getAllConsultations() {
    return _localDataSource.getAll();
  }

  @override
  Future<List<Consultation>> getConsultationsForPatient(int patientId) {
    return _localDataSource.getForPatient(patientId);
  }

  @override
  Future<Consultation?> getConsultationById(int id) {
    return _localDataSource.getById(id);
  }

  @override
  Future<Consultation> addConsultation(Consultation consultation) {
    return _localDataSource.add(consultation);
  }

  @override
  Future<Consultation> updateConsultation(Consultation consultation) {
    return _localDataSource.update(consultation);
  }

  @override
  Future<void> deleteConsultation(int id) {
    return _localDataSource.delete(id);
  }

  @override
  Future<void> deleteAllConsultationsForPatient(int patientId) {
    return _localDataSource.deleteAllForPatient(patientId);
  }

  @override
  Future<List<Consultation>> getConsultationsForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _localDataSource.getForPeriod(startDate, endDate);
  }

  @override
  Future<List<Consultation>> getTodayConsultations() {
    return _localDataSource.getTodayConsultations();
  }

  @override
  Stream<List<Consultation>> watchConsultations() {
    return _localDataSource.consultationsStream;
  }

  @override
  Stream<List<Consultation>> watchConsultationsForPatient(int patientId) {
    return _localDataSource.watchForPatient(patientId);
  }
}

