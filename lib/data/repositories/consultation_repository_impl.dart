import '../../core/models/consultation.dart';
import '../../domain/repositories/consultation_repository.dart';
import '../datasources/local/drift_datasource.dart';

/// Реализация репозитория консультаций.
class ConsultationRepositoryImpl implements ConsultationRepository {
  final DriftDataSource _driftDataSource;

  ConsultationRepositoryImpl(this._driftDataSource);

  @override
  Future<List<Consultation>> getAllConsultations() {
    return _driftDataSource.getAllConsultations();
  }

  @override
  Future<List<Consultation>> getConsultationsForPatient(int patientId) {
    return _driftDataSource.getConsultationsForPatient(patientId);
  }

  @override
  Future<Consultation?> getConsultationById(int id) {
    return _driftDataSource.getConsultationById(id);
  }

  @override
  Future<Consultation> addConsultation(Consultation consultation) {
    return _driftDataSource.addConsultation(consultation);
  }

  @override
  Future<Consultation> updateConsultation(Consultation consultation) {
    return _driftDataSource.updateConsultation(consultation);
  }

  @override
  Future<void> deleteConsultation(int id) {
    return _driftDataSource.deleteConsultation(id);
  }

  @override
  Future<void> deleteAllConsultationsForPatient(int patientId) {
    return _driftDataSource.deleteConsultationsForPatient(patientId);
  }

  @override
  Future<List<Consultation>> getConsultationsForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) {
    return _driftDataSource.getConsultationsForPeriod(startDate, endDate);
  }

  @override
  Future<List<Consultation>> getTodayConsultations() {
    return _driftDataSource.getTodayConsultations();
  }

  @override
  Stream<List<Consultation>> watchConsultations() {
    return _driftDataSource.watchAllConsultations();
  }

  @override
  Stream<List<Consultation>> watchConsultationsForPatient(int patientId) {
    return _driftDataSource.watchConsultationsForPatient(patientId);
  }
}
