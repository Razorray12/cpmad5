import '../../../../core/models/vital_sign.dart';
import '../dto/vital_sign_dto.dart';

/// Mapper для VitalSignDTO.
extension VitalSignMapper on VitalSignDTO {
  VitalSign toModel() {
    return VitalSign(
      id: id,
      patientId: patientId,
      timestamp: DateTime.parse(timestamp),
      temperature: double.tryParse(temperature) ?? 36.6,
      heartRate: int.tryParse(heartRate) ?? 70,
      respiratoryRate: int.tryParse(respiratoryRate) ?? 16,
      bloodPressure: BloodPressure.fromString(bloodPressure),
      oxygenSaturation: int.tryParse(oxygenSaturation) ?? 98,
      bloodGlucose: bloodGlucose != null ? double.tryParse(bloodGlucose!) : null,
    );
  }
}

extension VitalSignToDTO on VitalSign {
  VitalSignDTO toDTO() {
    return VitalSignDTO(
      id: id,
      patientId: patientId,
      timestamp: timestamp.toIso8601String(),
      temperature: temperature.toString(),
      heartRate: heartRate.toString(),
      respiratoryRate: respiratoryRate.toString(),
      bloodPressure: bloodPressure.toString(),
      oxygenSaturation: oxygenSaturation.toString(),
      bloodGlucose: bloodGlucose?.toString(),
    );
  }
}

