import '../../../../core/models/patient.dart';
import '../dto/patient_dto.dart';

/// Mapper для преобразования PatientDTO в бизнес-модель Patient и обратно.
/// Инкапсулирован внутри datasource и не должен использоваться извне.
extension PatientMapper on PatientDTO {
  /// Преобразование DTO в бизнес-модель.
  Patient toModel() {
    return Patient(
      id: id,
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
      status: PatientStatus.fromString(status),
      imageUrl: imageUrl,
    );
  }
}

/// Расширение для преобразования модели в DTO.
extension PatientToDTO on Patient {
  /// Преобразование бизнес-модели в DTO.
  PatientDTO toDTO() {
    return PatientDTO(
      id: id,
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
      status: status.displayName,
      imageUrl: imageUrl,
    );
  }
}

