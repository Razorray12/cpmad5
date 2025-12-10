import '../../../core/models/patient.dart';
import '../../repositories/patient_repository.dart';
import '../../repositories/vital_repository.dart';
import '../../repositories/consultation_repository.dart';

/// Use Case для добавления пациента.
class AddPatientUseCase {
  final PatientRepository _repository;

  AddPatientUseCase(this._repository);

  Future<Patient> execute({
    required String firstName,
    required String lastName,
    String? middleName,
    String? birthDate,
    String? phoneNumber,
    required String diagnosis,
    String? room,
    String? sex,
    String? admissionDate,
    String? medications,
    String? allergies,
    String? mainDoctor,
    String? mainDoctorID,
    required PatientStatus status,
    String? imageUrl,
  }) {
    final patient = Patient(
      id: 0, // ID будет присвоен в репозитории
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      birthDate: birthDate,
      phoneNumber: phoneNumber,
      diagnosis: diagnosis,
      room: room,
      sex: sex,
      admissionDate: admissionDate,
      medications: medications,
      allergies: allergies,
      mainDoctor: mainDoctor,
      mainDoctorID: mainDoctorID,
      status: status,
      imageUrl: imageUrl,
    );
    return _repository.addPatient(patient);
  }
}

/// Use Case для обновления данных пациента.
class UpdatePatientUseCase {
  final PatientRepository _repository;

  UpdatePatientUseCase(this._repository);

  Future<Patient> execute(Patient patient) {
    return _repository.updatePatient(patient);
  }
}

/// Use Case для удаления пациента.
/// Также удаляет связанные данные (показатели, консультации).
class DeletePatientUseCase {
  final PatientRepository _patientRepository;
  final VitalRepository _vitalRepository;
  final ConsultationRepository _consultationRepository;

  DeletePatientUseCase(
    this._patientRepository,
    this._vitalRepository,
    this._consultationRepository,
  );

  Future<void> execute(int patientId) async {
    // Удаляем связанные данные
    await _vitalRepository.deleteAllVitalsForPatient(patientId);
    await _consultationRepository.deleteAllConsultationsForPatient(patientId);
    // Удаляем пациента
    await _patientRepository.deletePatient(patientId);
  }
}

