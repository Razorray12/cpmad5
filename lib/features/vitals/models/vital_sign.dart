class VitalSign {
  final DateTime timestamp;
  final String temperature;
  final String heartRate;
  final String respiratoryRate;
  final String bloodPressure;
  final String oxygenSaturation;
  final String? bloodGlucose;

  const VitalSign({
    required this.timestamp,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
    required this.bloodPressure,
    required this.oxygenSaturation,
    this.bloodGlucose,
  });
}
