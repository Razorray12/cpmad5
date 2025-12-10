import 'dart:async';
import '../../../core/models/vital_sign.dart';
import 'dto/vital_sign_dto.dart';
import 'mappers/vital_sign_mapper.dart';

/// Локальный источник данных для показателей жизнедеятельности.
class LocalVitalDataSource {
  final Map<int, List<VitalSignDTO>> _vitalsByPatient = {};
  int _nextId = 1;

  final _vitalsControllers = <int, StreamController<List<VitalSign>>>{};

  StreamController<List<VitalSign>> _getController(int patientId) {
    return _vitalsControllers.putIfAbsent(
      patientId,
      () => StreamController<List<VitalSign>>.broadcast(),
    );
  }

  /// Стрим показателей для пациента.
  Stream<List<VitalSign>> watchVitals(int patientId) {
    return _getController(patientId).stream;
  }

  /// Получить все показатели пациента.
  Future<List<VitalSign>> getForPatient(int patientId) async {
    final dtos = _vitalsByPatient[patientId] ?? [];
    return dtos.map((dto) => dto.toModel()).toList();
  }

  /// Получить последние показатели.
  Future<VitalSign?> getLatest(int patientId) async {
    final dtos = _vitalsByPatient[patientId];
    if (dtos == null || dtos.isEmpty) return null;
    
    final sorted = List<VitalSignDTO>.from(dtos)
      ..sort((a, b) => DateTime.parse(b.timestamp)
          .compareTo(DateTime.parse(a.timestamp)));
    
    return sorted.first.toModel();
  }

  /// Добавить показатели.
  Future<VitalSign> add(VitalSign vitals) async {
    final dto = VitalSignDTO(
      id: _nextId++,
      patientId: vitals.patientId,
      timestamp: vitals.timestamp.toIso8601String(),
      temperature: vitals.temperature.toString(),
      heartRate: vitals.heartRate.toString(),
      respiratoryRate: vitals.respiratoryRate.toString(),
      bloodPressure: vitals.bloodPressure.toString(),
      oxygenSaturation: vitals.oxygenSaturation.toString(),
      bloodGlucose: vitals.bloodGlucose?.toString(),
    );
    
    _vitalsByPatient.putIfAbsent(vitals.patientId, () => []).add(dto);
    _notifyListeners(vitals.patientId);
    
    return dto.toModel();
  }

  /// Удалить показатели.
  Future<void> delete(int id) async {
    for (final entry in _vitalsByPatient.entries) {
      final index = entry.value.indexWhere((v) => v.id == id);
      if (index != -1) {
        entry.value.removeAt(index);
        _notifyListeners(entry.key);
        break;
      }
    }
  }

  /// Удалить все показатели пациента.
  Future<void> deleteAllForPatient(int patientId) async {
    _vitalsByPatient.remove(patientId);
    _notifyListeners(patientId);
  }

  /// Получить показатели за период.
  Future<List<VitalSign>> getForPeriod(
    int patientId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final dtos = _vitalsByPatient[patientId] ?? [];
    return dtos
        .where((dto) {
          final timestamp = DateTime.parse(dto.timestamp);
          return timestamp.isAfter(startDate) && timestamp.isBefore(endDate);
        })
        .map((dto) => dto.toModel())
        .toList();
  }

  void _notifyListeners(int patientId) {
    final dtos = _vitalsByPatient[patientId] ?? [];
    _getController(patientId).add(dtos.map((dto) => dto.toModel()).toList());
  }

  void dispose() {
    for (final controller in _vitalsControllers.values) {
      controller.close();
    }
  }
}

