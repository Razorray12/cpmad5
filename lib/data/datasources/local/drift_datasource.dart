import 'dart:async';
import '../../../core/models/patient.dart' as models;
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
}
