/// Бизнес-модель показателей жизнедеятельности.
class VitalSign {
  final int? id;
  final int patientId;
  final DateTime timestamp;
  final double temperature;
  final int heartRate;
  final int respiratoryRate;
  final BloodPressure bloodPressure;
  final int oxygenSaturation;
  final double? bloodGlucose;

  const VitalSign({
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

  /// Проверка на нормальные показатели температуры.
  bool get isTemperatureNormal => temperature >= 36.0 && temperature <= 37.2;

  /// Проверка на нормальный пульс.
  bool get isHeartRateNormal => heartRate >= 60 && heartRate <= 100;

  /// Проверка на нормальное давление.
  bool get isBloodPressureNormal =>
      bloodPressure.systolic >= 90 &&
      bloodPressure.systolic <= 140 &&
      bloodPressure.diastolic >= 60 &&
      bloodPressure.diastolic <= 90;

  /// Проверка на нормальное насыщение кислородом.
  bool get isOxygenSaturationNormal => oxygenSaturation >= 95;

  /// Общая оценка: все показатели в норме.
  bool get allVitalsNormal =>
      isTemperatureNormal &&
      isHeartRateNormal &&
      isBloodPressureNormal &&
      isOxygenSaturationNormal;

  VitalSign copyWith({
    int? id,
    int? patientId,
    DateTime? timestamp,
    double? temperature,
    int? heartRate,
    int? respiratoryRate,
    BloodPressure? bloodPressure,
    int? oxygenSaturation,
    double? bloodGlucose,
  }) {
    return VitalSign(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      timestamp: timestamp ?? this.timestamp,
      temperature: temperature ?? this.temperature,
      heartRate: heartRate ?? this.heartRate,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      bloodGlucose: bloodGlucose ?? this.bloodGlucose,
    );
  }
}

/// Модель артериального давления.
class BloodPressure {
  final int systolic;
  final int diastolic;

  const BloodPressure({
    required this.systolic,
    required this.diastolic,
  });

  /// Строковое представление (120/80).
  @override
  String toString() => '$systolic/$diastolic';

  /// Парсинг из строки формата "120/80".
  static BloodPressure fromString(String value) {
    final parts = value.split('/');
    if (parts.length == 2) {
      return BloodPressure(
        systolic: int.tryParse(parts[0]) ?? 120,
        diastolic: int.tryParse(parts[1]) ?? 80,
      );
    }
    return const BloodPressure(systolic: 120, diastolic: 80);
  }
}

