import '../../../core/models/vital_sign.dart';
import '../../repositories/vital_repository.dart';

/// Use Case для получения показателей пациента.
class GetVitalsUseCase {
  final VitalRepository _repository;

  GetVitalsUseCase(this._repository);

  Future<List<VitalSign>> execute(int patientId) {
    return _repository.getVitalsForPatient(patientId);
  }

  Stream<List<VitalSign>> watch(int patientId) {
    return _repository.watchVitalsForPatient(patientId);
  }
}

/// Use Case для получения последних показателей.
class GetLatestVitalsUseCase {
  final VitalRepository _repository;

  GetLatestVitalsUseCase(this._repository);

  Future<VitalSign?> execute(int patientId) {
    return _repository.getLatestVitals(patientId);
  }
}

/// Use Case для добавления показателей.
class AddVitalsUseCase {
  final VitalRepository _repository;

  AddVitalsUseCase(this._repository);

  Future<VitalSign> execute({
    required int patientId,
    required double temperature,
    required int heartRate,
    required int respiratoryRate,
    required BloodPressure bloodPressure,
    required int oxygenSaturation,
    double? bloodGlucose,
  }) {
    final vitals = VitalSign(
      patientId: patientId,
      timestamp: DateTime.now(),
      temperature: temperature,
      heartRate: heartRate,
      respiratoryRate: respiratoryRate,
      bloodPressure: bloodPressure,
      oxygenSaturation: oxygenSaturation,
      bloodGlucose: bloodGlucose,
    );
    return _repository.addVitals(vitals);
  }
}

/// Use Case для удаления показателей.
class DeleteVitalsUseCase {
  final VitalRepository _repository;

  DeleteVitalsUseCase(this._repository);

  Future<void> execute(int vitalsId) {
    return _repository.deleteVitals(vitalsId);
  }
}

/// Use Case для анализа показателей.
class AnalyzeVitalsUseCase {
  final VitalRepository _repository;

  AnalyzeVitalsUseCase(this._repository);

  /// Проверить, есть ли отклонения в последних показателях.
  Future<VitalsAnalysisResult> execute(int patientId) async {
    final latest = await _repository.getLatestVitals(patientId);
    
    if (latest == null) {
      return VitalsAnalysisResult(
        hasData: false,
        allNormal: true,
        warnings: [],
      );
    }

    final warnings = <String>[];

    if (!latest.isTemperatureNormal) {
      warnings.add('Температура: ${latest.temperature}°C');
    }
    if (!latest.isHeartRateNormal) {
      warnings.add('Пульс: ${latest.heartRate} уд/мин');
    }
    if (!latest.isBloodPressureNormal) {
      warnings.add('Давление: ${latest.bloodPressure}');
    }
    if (!latest.isOxygenSaturationNormal) {
      warnings.add('SpO2: ${latest.oxygenSaturation}%');
    }

    return VitalsAnalysisResult(
      hasData: true,
      allNormal: latest.allVitalsNormal,
      warnings: warnings,
      latestVitals: latest,
    );
  }
}

/// Результат анализа показателей.
class VitalsAnalysisResult {
  final bool hasData;
  final bool allNormal;
  final List<String> warnings;
  final VitalSign? latestVitals;

  VitalsAnalysisResult({
    required this.hasData,
    required this.allNormal,
    required this.warnings,
    this.latestVitals,
  });
}

