import 'dart:async';
import '../../../core/models/consultation.dart';
import 'dto/consultation_dto.dart';
import 'mappers/consultation_mapper.dart';

/// Локальный источник данных для консультаций.
class LocalConsultationDataSource {
  final List<ConsultationDTO> _consultations = [];
  int _nextId = 1;

  final _consultationsController = StreamController<List<Consultation>>.broadcast();
  final _patientConsultationsControllers = <int, StreamController<List<Consultation>>>{};

  /// Стрим всех консультаций.
  Stream<List<Consultation>> get consultationsStream => _consultationsController.stream;

  /// Стрим консультаций для пациента.
  Stream<List<Consultation>> watchForPatient(int patientId) {
    return _patientConsultationsControllers
        .putIfAbsent(patientId, () => StreamController<List<Consultation>>.broadcast())
        .stream;
  }

  /// Получить все консультации.
  Future<List<Consultation>> getAll() async {
    return _consultations.map((dto) => dto.toModel()).toList();
  }

  /// Получить консультации пациента.
  Future<List<Consultation>> getForPatient(int patientId) async {
    return _consultations
        .where((dto) => dto.patientId == patientId)
        .map((dto) => dto.toModel())
        .toList();
  }

  /// Получить консультацию по ID.
  Future<Consultation?> getById(int id) async {
    try {
      final dto = _consultations.firstWhere((c) => c.id == id);
      return dto.toModel();
    } catch (_) {
      return null;
    }
  }

  /// Добавить консультацию.
  Future<Consultation> add(Consultation consultation) async {
    final dto = ConsultationDTO(
      id: _nextId++,
      patientId: consultation.patientId,
      dateTime: consultation.dateTime.toIso8601String(),
      doctorId: consultation.doctorId,
      doctorName: consultation.doctorName,
      note: consultation.note,
      type: consultation.type.name,
    );
    _consultations.add(dto);
    _notifyListeners();
    _notifyPatientListeners(consultation.patientId);
    return dto.toModel();
  }

  /// Обновить консультацию.
  Future<Consultation> update(Consultation consultation) async {
    final index = _consultations.indexWhere((c) => c.id == consultation.id);
    if (index != -1) {
      final dto = consultation.toDTO();
      _consultations[index] = dto;
      _notifyListeners();
      _notifyPatientListeners(consultation.patientId);
      return dto.toModel();
    }
    throw Exception('Консультация не найдена');
  }

  /// Удалить консультацию.
  Future<void> delete(int id) async {
    final consultation = _consultations.firstWhere(
      (c) => c.id == id,
      orElse: () => throw Exception('Консультация не найдена'),
    );
    final patientId = consultation.patientId;
    _consultations.removeWhere((c) => c.id == id);
    _notifyListeners();
    _notifyPatientListeners(patientId);
  }

  /// Удалить все консультации пациента.
  Future<void> deleteAllForPatient(int patientId) async {
    _consultations.removeWhere((c) => c.patientId == patientId);
    _notifyListeners();
    _notifyPatientListeners(patientId);
  }

  /// Получить сегодняшние консультации.
  Future<List<Consultation>> getTodayConsultations() async {
    final now = DateTime.now();
    return _consultations
        .where((dto) {
          final date = DateTime.parse(dto.dateTime);
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        })
        .map((dto) => dto.toModel())
        .toList();
  }

  /// Получить консультации за период.
  Future<List<Consultation>> getForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return _consultations
        .where((dto) {
          final date = DateTime.parse(dto.dateTime);
          return date.isAfter(startDate) && date.isBefore(endDate);
        })
        .map((dto) => dto.toModel())
        .toList();
  }

  void _notifyListeners() {
    _consultationsController.add(_consultations.map((dto) => dto.toModel()).toList());
  }

  void _notifyPatientListeners(int patientId) {
    final controller = _patientConsultationsControllers[patientId];
    if (controller != null) {
      final patientConsultations = _consultations
          .where((dto) => dto.patientId == patientId)
          .map((dto) => dto.toModel())
          .toList();
      controller.add(patientConsultations);
    }
  }

  void dispose() {
    _consultationsController.close();
    for (final controller in _patientConsultationsControllers.values) {
      controller.close();
    }
  }
}

