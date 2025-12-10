import '../../../core/models/patient.dart';
import '../../repositories/patient_repository.dart';

/// Use Case для получения списка пациентов.
class GetPatientsUseCase {
  final PatientRepository _repository;

  GetPatientsUseCase(this._repository);

  /// Получить всех пациентов.
  Future<List<Patient>> execute() {
    return _repository.getAllPatients();
  }

  /// Получить стрим пациентов.
  Stream<List<Patient>> watch() {
    return _repository.watchPatients();
  }
}

/// Use Case для получения пациента по ID.
class GetPatientByIdUseCase {
  final PatientRepository _repository;

  GetPatientByIdUseCase(this._repository);

  Future<Patient?> execute(int id) {
    return _repository.getPatientById(id);
  }
}

/// Use Case для поиска пациентов.
class SearchPatientsUseCase {
  final PatientRepository _repository;

  SearchPatientsUseCase(this._repository);

  Future<List<Patient>> execute(String query) {
    return _repository.searchPatients(query);
  }
}

/// Use Case для получения пациентов по статусу.
class GetPatientsByStatusUseCase {
  final PatientRepository _repository;

  GetPatientsByStatusUseCase(this._repository);

  Future<List<Patient>> execute(PatientStatus status) {
    return _repository.getPatientsByStatus(status);
  }
}

