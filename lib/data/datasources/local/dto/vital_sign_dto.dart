/// DTO структура показателей жизнедеятельности.
class VitalSignDTO {
  final int? id;
  final int patientId;
  final String timestamp;
  final String temperature;
  final String heartRate;
  final String respiratoryRate;
  final String bloodPressure;
  final String oxygenSaturation;
  final String? bloodGlucose;

  const VitalSignDTO({
    this.id,
    required this.patientId,
    required this.timestamp,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
    required this.bloodPressure,
    required this.oxygenSaturation,
    this.bloodGlucose,
  });

  factory VitalSignDTO.fromJson(Map<String, dynamic> json) {
    return VitalSignDTO(
      id: json['id'] as int?,
      patientId: json['patientId'] as int,
      timestamp: json['timestamp'] as String,
      temperature: json['temperature'] as String,
      heartRate: json['heartRate'] as String,
      respiratoryRate: json['respiratoryRate'] as String,
      bloodPressure: json['bloodPressure'] as String,
      oxygenSaturation: json['oxygenSaturation'] as String,
      bloodGlucose: json['bloodGlucose'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'timestamp': timestamp,
      'temperature': temperature,
      'heartRate': heartRate,
      'respiratoryRate': respiratoryRate,
      'bloodPressure': bloodPressure,
      'oxygenSaturation': oxygenSaturation,
      'bloodGlucose': bloodGlucose,
    };
  }
}

