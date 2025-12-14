import 'dart:async';
import '../../../core/models/patient.dart' as models;
import '../../../core/models/vital_sign.dart' as vital_models;
import '../../../core/models/consultation.dart' as consultation_models;
import '../../database/app_database.dart';
import 'package:drift/drift.dart';

/// DataSource для работы с базой данных Drift (SQLite).
/// 
/// Предоставляет типобезопасный доступ к данным пациентов
/// с поддержкой реактивных обновлений через Streams.
class DriftDataSource {
  late AppDatabase _database;
  bool _isInitialized = false;

  /// Инициализация базы данных.
  Future<void> init() async {
    if (_isInitialized) return;
    _database = AppDatabase();
    _isInitialized = true;
  }

  /// Получение экземпляра базы данных.
  AppDatabase get database {
    if (!_isInitialized) {
      throw StateError('DriftDataSource не инициализирован. Вызовите init() перед использованием.');
    }
    return _database;
  }

  // ============================================
  // ПАЦИЕНТЫ - CRUD
  // ============================================

  /// Получить всех пациентов.
  Future<List<models.Patient>> getAllPatients() async {
    final dbPatients = await _database.getAllPatients();
    return dbPatients.map(_mapToModelPatient).toList();
  }

  /// Получить пациента по ID.
  Future<models.Patient?> getPatientById(int id) async {
    final dbPatient = await _database.getPatientById(id);
    if (dbPatient == null) return null;
    return _mapToModelPatient(dbPatient);
  }

  /// Добавить пациента.
  Future<models.Patient> addPatient(models.Patient patient) async {
    final now = DateTime.now();
    final companion = PatientsCompanion.insert(
      firstName: patient.firstName,
      lastName: patient.lastName,
      middleName: Value(patient.middleName),
      birthDate: Value(patient.birthDate),
      phoneNumber: Value(patient.phoneNumber),
      diagnosis: patient.diagnosis,
      room: Value(patient.room),
      sex: Value(patient.sex),
      admissionDate: Value(patient.admissionDate),
      medications: Value(patient.medications),
      allergies: Value(patient.allergies),
      mainDoctor: Value(patient.mainDoctor),
      mainDoctorId: Value(patient.mainDoctorID),
      status: patient.status.displayName,
      imageUrl: Value(patient.imageUrl),
      createdAt: now,
      updatedAt: now,
    );
    
    final id = await _database.insertPatient(companion);
    // ignore: avoid_print
    print('DriftDataSource: Patient saved with id=$id');
    return patient.copyWith(id: id);
  }

  /// Обновить пациента.
  Future<models.Patient> updatePatient(models.Patient patient) async {
    final companion = PatientsCompanion(
      firstName: Value(patient.firstName),
      lastName: Value(patient.lastName),
      middleName: Value(patient.middleName),
      birthDate: Value(patient.birthDate),
      phoneNumber: Value(patient.phoneNumber),
      diagnosis: Value(patient.diagnosis),
      room: Value(patient.room),
      sex: Value(patient.sex),
      admissionDate: Value(patient.admissionDate),
      medications: Value(patient.medications),
      allergies: Value(patient.allergies),
      mainDoctor: Value(patient.mainDoctor),
      mainDoctorId: Value(patient.mainDoctorID),
      status: Value(patient.status.displayName),
      imageUrl: Value(patient.imageUrl),
      updatedAt: Value(DateTime.now()),
    );
    
    await _database.updatePatientById(patient.id, companion);
    return patient;
  }

  /// Удалить пациента.
  Future<void> deletePatient(int id) async {
    await _database.deletePatient(id);
  }

  /// Поиск пациентов.
  Future<List<models.Patient>> searchPatients(String query) async {
    final dbPatients = await _database.searchPatients(query);
    return dbPatients.map(_mapToModelPatient).toList();
  }

  /// Получить пациентов по статусу.
  Future<List<models.Patient>> getPatientsByStatus(models.PatientStatus status) async {
    final dbPatients = await _database.getPatientsByStatus(status.displayName);
    return dbPatients.map(_mapToModelPatient).toList();
  }

  // ============================================
  // ПАЦИЕНТЫ - STREAMS
  // ============================================

  /// Стрим всех пациентов (реактивное обновление).
  Stream<List<models.Patient>> watchAllPatients() {
    return _database.watchAllPatients().map(
      (list) => list.map(_mapToModelPatient).toList(),
    );
  }

  // ============================================
  // СТАТИСТИКА
  // ============================================

  /// Получить количество пациентов.
  Future<int> getPatientsCount() async {
    return await _database.getPatientsCount();
  }

  // ============================================
  // УТИЛИТЫ
  // ============================================

  /// Закрытие соединения с базой данных.
  Future<void> close() async {
    if (_isInitialized) {
      await _database.close();
      _isInitialized = false;
    }
  }

  /// Маппинг из DB модели в бизнес-модель.
  models.Patient _mapToModelPatient(Patient dbPatient) {
    return models.Patient(
      id: dbPatient.id,
      firstName: dbPatient.firstName,
      lastName: dbPatient.lastName,
      middleName: dbPatient.middleName,
      birthDate: dbPatient.birthDate,
      phoneNumber: dbPatient.phoneNumber,
      diagnosis: dbPatient.diagnosis,
      room: dbPatient.room,
      sex: dbPatient.sex,
      admissionDate: dbPatient.admissionDate,
      medications: dbPatient.medications,
      allergies: dbPatient.allergies,
      mainDoctor: dbPatient.mainDoctor,
      mainDoctorID: dbPatient.mainDoctorId,
      status: models.PatientStatus.fromString(dbPatient.status),
      imageUrl: dbPatient.imageUrl,
    );
  }

  // ============================================
  // ПОКАЗАТЕЛИ ЖИЗНЕДЕЯТЕЛЬНОСТИ - CRUD
  // ============================================

  /// Получить все показатели для пациента.
  Future<List<vital_models.VitalSign>> getVitalsForPatient(int patientId) async {
    final dbVitals = await _database.getVitalsForPatient(patientId);
    return dbVitals.map(_mapToModelVitalSign).toList();
  }

  /// Получить последние показатели пациента.
  Future<vital_models.VitalSign?> getLatestVitals(int patientId) async {
    final dbVital = await _database.getLatestVitals(patientId);
    if (dbVital == null) return null;
    return _mapToModelVitalSign(dbVital);
  }

  /// Добавить показатели.
  Future<vital_models.VitalSign> addVitalSign(vital_models.VitalSign vitalSign) async {
    final companion = VitalSignsCompanion.insert(
      patientId: vitalSign.patientId,
      timestamp: vitalSign.timestamp,
      temperature: vitalSign.temperature,
      heartRate: vitalSign.heartRate,
      respiratoryRate: vitalSign.respiratoryRate,
      bloodPressure: vitalSign.bloodPressure.toString(),
      oxygenSaturation: vitalSign.oxygenSaturation,
      bloodGlucose: Value(vitalSign.bloodGlucose),
      createdAt: DateTime.now(),
    );
    
    final id = await _database.insertVitalSign(companion);
    // ignore: avoid_print
    print('DriftDataSource: VitalSign saved with id=$id for patient=${vitalSign.patientId}');
    return vitalSign.copyWith(id: id);
  }

  /// Удалить показатели.
  Future<void> deleteVitalSign(int id) async {
    await _database.deleteVitalSign(id);
  }

  /// Удалить все показатели пациента.
  Future<void> deleteVitalsForPatient(int patientId) async {
    await _database.deleteVitalsForPatient(patientId);
  }

  /// Получить показатели за период.
  Future<List<vital_models.VitalSign>> getVitalsForPeriod(
    int patientId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final dbVitals = await _database.getVitalsForPeriod(patientId, startDate, endDate);
    return dbVitals.map(_mapToModelVitalSign).toList();
  }

  /// Стрим показателей пациента.
  Stream<List<vital_models.VitalSign>> watchVitalsForPatient(int patientId) {
    return _database.watchVitalsForPatient(patientId).map(
      (list) => list.map(_mapToModelVitalSign).toList(),
    );
  }

  /// Маппинг из DB модели в бизнес-модель VitalSign.
  vital_models.VitalSign _mapToModelVitalSign(VitalSign dbVital) {
    return vital_models.VitalSign(
      id: dbVital.id,
      patientId: dbVital.patientId,
      timestamp: dbVital.timestamp,
      temperature: dbVital.temperature,
      heartRate: dbVital.heartRate,
      respiratoryRate: dbVital.respiratoryRate,
      bloodPressure: vital_models.BloodPressure.fromString(dbVital.bloodPressure),
      oxygenSaturation: dbVital.oxygenSaturation,
      bloodGlucose: dbVital.bloodGlucose,
    );
  }

  // ============================================
  // КОНСУЛЬТАЦИИ - CRUD
  // ============================================

  /// Получить все консультации.
  Future<List<consultation_models.Consultation>> getAllConsultations() async {
    final dbConsultations = await _database.getAllConsultations();
    return dbConsultations.map(_mapToModelConsultation).toList();
  }

  /// Получить консультации пациента.
  Future<List<consultation_models.Consultation>> getConsultationsForPatient(int patientId) async {
    final dbConsultations = await _database.getConsultationsForPatient(patientId);
    return dbConsultations.map(_mapToModelConsultation).toList();
  }

  /// Получить консультацию по ID.
  Future<consultation_models.Consultation?> getConsultationById(int id) async {
    final dbConsultation = await _database.getConsultationById(id);
    if (dbConsultation == null) return null;
    return _mapToModelConsultation(dbConsultation);
  }

  /// Добавить консультацию.
  Future<consultation_models.Consultation> addConsultation(consultation_models.Consultation consultation) async {
    final now = DateTime.now();
    final companion = ConsultationsCompanion.insert(
      patientId: consultation.patientId,
      scheduledAt: consultation.dateTime,
      doctorId: Value(consultation.doctorId),
      doctorName: Value(consultation.doctorName),
      note: consultation.note,
      type: consultation.type.name,
      createdAt: now,
      updatedAt: now,
    );
    
    final id = await _database.insertConsultation(companion);
    // ignore: avoid_print
    print('DriftDataSource: Consultation saved with id=$id for patient=${consultation.patientId}');
    return consultation.copyWith(id: id);
  }

  /// Обновить консультацию.
  Future<consultation_models.Consultation> updateConsultation(consultation_models.Consultation consultation) async {
    final companion = ConsultationsCompanion(
      scheduledAt: Value(consultation.dateTime),
      doctorId: Value(consultation.doctorId),
      doctorName: Value(consultation.doctorName),
      note: Value(consultation.note),
      type: Value(consultation.type.name),
      updatedAt: Value(DateTime.now()),
    );
    
    await _database.updateConsultationById(consultation.id!, companion);
    return consultation;
  }

  /// Удалить консультацию.
  Future<void> deleteConsultation(int id) async {
    await _database.deleteConsultation(id);
  }

  /// Удалить консультации пациента.
  Future<void> deleteConsultationsForPatient(int patientId) async {
    await _database.deleteConsultationsForPatient(patientId);
  }

  /// Получить консультации на сегодня.
  Future<List<consultation_models.Consultation>> getTodayConsultations() async {
    final dbConsultations = await _database.getTodayConsultations();
    return dbConsultations.map(_mapToModelConsultation).toList();
  }

  /// Получить консультации за период.
  Future<List<consultation_models.Consultation>> getConsultationsForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final dbConsultations = await _database.getConsultationsForPeriod(startDate, endDate);
    return dbConsultations.map(_mapToModelConsultation).toList();
  }

  /// Стрим всех консультаций.
  Stream<List<consultation_models.Consultation>> watchAllConsultations() {
    return _database.watchAllConsultations().map(
      (list) => list.map(_mapToModelConsultation).toList(),
    );
  }

  /// Стрим консультаций пациента.
  Stream<List<consultation_models.Consultation>> watchConsultationsForPatient(int patientId) {
    return _database.watchConsultationsForPatient(patientId).map(
      (list) => list.map(_mapToModelConsultation).toList(),
    );
  }

  /// Маппинг из DB модели в бизнес-модель Consultation.
  consultation_models.Consultation _mapToModelConsultation(Consultation dbConsultation) {
    return consultation_models.Consultation(
      id: dbConsultation.id,
      patientId: dbConsultation.patientId,
      dateTime: dbConsultation.scheduledAt,
      doctorId: dbConsultation.doctorId,
      doctorName: dbConsultation.doctorName,
      note: dbConsultation.note,
      type: consultation_models.ConsultationType.fromString(dbConsultation.type),
    );
  }
}
