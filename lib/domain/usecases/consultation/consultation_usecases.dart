import '../../../core/models/consultation.dart';
import '../../repositories/consultation_repository.dart';

/// Use Case для получения консультаций.
class GetConsultationsUseCase {
  final ConsultationRepository _repository;

  GetConsultationsUseCase(this._repository);

  Future<List<Consultation>> execute() {
    return _repository.getAllConsultations();
  }

  Future<List<Consultation>> forPatient(int patientId) {
    return _repository.getConsultationsForPatient(patientId);
  }

  Stream<List<Consultation>> watch() {
    return _repository.watchConsultations();
  }

  Stream<List<Consultation>> watchForPatient(int patientId) {
    return _repository.watchConsultationsForPatient(patientId);
  }
}

/// Use Case для получения сегодняшних консультаций.
class GetTodayConsultationsUseCase {
  final ConsultationRepository _repository;

  GetTodayConsultationsUseCase(this._repository);

  Future<List<Consultation>> execute() {
    return _repository.getTodayConsultations();
  }
}

/// Use Case для добавления консультации.
class AddConsultationUseCase {
  final ConsultationRepository _repository;

  AddConsultationUseCase(this._repository);

  Future<Consultation> execute({
    required int patientId,
    required DateTime dateTime,
    String? doctorId,
    String? doctorName,
    required String note,
    ConsultationType type = ConsultationType.regular,
  }) {
    final consultation = Consultation(
      patientId: patientId,
      dateTime: dateTime,
      doctorId: doctorId,
      doctorName: doctorName,
      note: note,
      type: type,
    );
    return _repository.addConsultation(consultation);
  }
}

/// Use Case для обновления консультации.
class UpdateConsultationUseCase {
  final ConsultationRepository _repository;

  UpdateConsultationUseCase(this._repository);

  Future<Consultation> execute(Consultation consultation) {
    return _repository.updateConsultation(consultation);
  }
}

/// Use Case для удаления консультации.
class DeleteConsultationUseCase {
  final ConsultationRepository _repository;

  DeleteConsultationUseCase(this._repository);

  Future<void> execute(int consultationId) {
    return _repository.deleteConsultation(consultationId);
  }
}

