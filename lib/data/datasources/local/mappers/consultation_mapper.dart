import '../../../../core/models/consultation.dart';
import '../dto/consultation_dto.dart';

/// Mapper для ConsultationDTO.
extension ConsultationMapper on ConsultationDTO {
  Consultation toModel() {
    return Consultation(
      id: id,
      patientId: patientId,
      dateTime: DateTime.parse(dateTime),
      doctorId: doctorId,
      doctorName: doctorName,
      note: note,
      type: ConsultationType.fromString(type),
    );
  }
}

extension ConsultationToDTO on Consultation {
  ConsultationDTO toDTO() {
    return ConsultationDTO(
      id: id,
      patientId: patientId,
      dateTime: dateTime.toIso8601String(),
      doctorId: doctorId,
      doctorName: doctorName,
      note: note,
      type: type.name,
    );
  }
}

