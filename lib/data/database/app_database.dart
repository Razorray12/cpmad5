import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// ============================================
// ТАБЛИЦЫ БАЗЫ ДАННЫХ
// ============================================

/// Таблица пациентов.
class Patients extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get middleName => text().nullable()();
  TextColumn get birthDate => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get diagnosis => text()();
  TextColumn get room => text().nullable()();
  TextColumn get sex => text().nullable()();
  TextColumn get admissionDate => text().nullable()();
  TextColumn get medications => text().nullable()();
  TextColumn get allergies => text().nullable()();
  TextColumn get mainDoctor => text().nullable()();
  TextColumn get mainDoctorId => text().nullable()();
  TextColumn get status => text()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

/// Таблица показателей жизнедеятельности.
class VitalSigns extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  DateTimeColumn get timestamp => dateTime()();
  RealColumn get temperature => real()();
  IntColumn get heartRate => integer()();
  IntColumn get respiratoryRate => integer()();
  TextColumn get bloodPressure => text()(); // Формат: "120/80"
  IntColumn get oxygenSaturation => integer()();
  RealColumn get bloodGlucose => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

/// Таблица консультаций.
class Consultations extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get patientId => integer().references(Patients, #id)();
  DateTimeColumn get scheduledAt => dateTime()();
  TextColumn get doctorId => text().nullable()();
  TextColumn get doctorName => text().nullable()();
  TextColumn get note => text()();
  TextColumn get type => text()(); // regular, urgent, followUp, initial
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

// ============================================
// БАЗА ДАННЫХ
// ============================================

@DriftDatabase(tables: [Patients, VitalSigns, Consultations])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(vitalSigns);
          await m.createTable(consultations);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    // Для веб-платформы нужны WASM файлы
    return driftDatabase(
      name: 'medical_app.db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('/sqlite3.wasm'),
        driftWorker: Uri.parse('/drift_worker.js'),
        // Используем IndexedDB для постоянного хранения
        onResult: (result) {
          // ignore: avoid_print
          print('Drift web storage: ${result.chosenImplementation}');
          if (result.missingFeatures.isNotEmpty) {
            // ignore: avoid_print
            print('Drift web missing features: ${result.missingFeatures}');
          }
        },
      ),
    );
  }

  // ============================================
  // CRUD ОПЕРАЦИИ ДЛЯ ПАЦИЕНТОВ
  // ============================================

  /// Получить всех пациентов.
  Future<List<Patient>> getAllPatients() {
    return select(patients).get();
  }

  /// Получить пациента по ID.
  Future<Patient?> getPatientById(int id) {
    return (select(patients)..where((p) => p.id.equals(id))).getSingleOrNull();
  }

  /// Добавить пациента.
  Future<int> insertPatient(PatientsCompanion patient) {
    return into(patients).insert(patient);
  }

  /// Обновить пациента.
  Future<bool> updatePatientById(int id, PatientsCompanion patient) {
    return (update(patients)..where((p) => p.id.equals(id)))
        .write(patient)
        .then((rows) => rows > 0);
  }

  /// Удалить пациента.
  Future<int> deletePatient(int id) {
    return (delete(patients)..where((p) => p.id.equals(id))).go();
  }

  /// Поиск пациентов.
  Future<List<Patient>> searchPatients(String query) {
    final lowerQuery = '%${query.toLowerCase()}%';
    return (select(patients)
          ..where((p) =>
              p.firstName.lower().like(lowerQuery) |
              p.lastName.lower().like(lowerQuery) |
              p.diagnosis.lower().like(lowerQuery)))
        .get();
  }

  /// Стрим всех пациентов.
  Stream<List<Patient>> watchAllPatients() {
    return select(patients).watch();
  }

  /// Получить количество пациентов.
  Future<int> getPatientsCount() async {
    final count = await (selectOnly(patients)
          ..addColumns([patients.id.count()]))
        .getSingle();
    return count.read(patients.id.count()) ?? 0;
  }

  /// Получить пациентов по статусу.
  Future<List<Patient>> getPatientsByStatus(String status) {
    return (select(patients)..where((p) => p.status.equals(status))).get();
  }

  // ============================================
  // CRUD ОПЕРАЦИИ ДЛЯ ПОКАЗАТЕЛЕЙ ЖИЗНЕДЕЯТЕЛЬНОСТИ
  // ============================================

  /// Получить все показатели для пациента.
  Future<List<VitalSign>> getVitalsForPatient(int patientId) {
    return (select(vitalSigns)
          ..where((v) => v.patientId.equals(patientId))
          ..orderBy([(v) => OrderingTerm.desc(v.timestamp)]))
        .get();
  }

  /// Получить последние показатели пациента.
  Future<VitalSign?> getLatestVitals(int patientId) {
    return (select(vitalSigns)
          ..where((v) => v.patientId.equals(patientId))
          ..orderBy([(v) => OrderingTerm.desc(v.timestamp)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Добавить показатели.
  Future<int> insertVitalSign(VitalSignsCompanion vitalSign) {
    return into(vitalSigns).insert(vitalSign);
  }

  /// Удалить показатели.
  Future<int> deleteVitalSign(int id) {
    return (delete(vitalSigns)..where((v) => v.id.equals(id))).go();
  }

  /// Удалить все показатели пациента.
  Future<int> deleteVitalsForPatient(int patientId) {
    return (delete(vitalSigns)..where((v) => v.patientId.equals(patientId))).go();
  }

  /// Получить показатели за период.
  Future<List<VitalSign>> getVitalsForPeriod(
    int patientId,
    DateTime startDate,
    DateTime endDate,
  ) {
    return (select(vitalSigns)
          ..where((v) =>
              v.patientId.equals(patientId) &
              v.timestamp.isBiggerOrEqualValue(startDate) &
              v.timestamp.isSmallerOrEqualValue(endDate))
          ..orderBy([(v) => OrderingTerm.desc(v.timestamp)]))
        .get();
  }

  /// Стрим показателей пациента.
  Stream<List<VitalSign>> watchVitalsForPatient(int patientId) {
    return (select(vitalSigns)
          ..where((v) => v.patientId.equals(patientId))
          ..orderBy([(v) => OrderingTerm.desc(v.timestamp)]))
        .watch();
  }

  // ============================================
  // CRUD ОПЕРАЦИИ ДЛЯ КОНСУЛЬТАЦИЙ
  // ============================================

  /// Получить все консультации.
  Future<List<Consultation>> getAllConsultations() {
    return (select(consultations)
          ..orderBy([(c) => OrderingTerm.desc(c.scheduledAt)]))
        .get();
  }

  /// Получить консультации пациента.
  Future<List<Consultation>> getConsultationsForPatient(int patientId) {
    return (select(consultations)
          ..where((c) => c.patientId.equals(patientId))
          ..orderBy([(c) => OrderingTerm.desc(c.scheduledAt)]))
        .get();
  }

  /// Получить консультацию по ID.
  Future<Consultation?> getConsultationById(int id) {
    return (select(consultations)..where((c) => c.id.equals(id))).getSingleOrNull();
  }

  /// Добавить консультацию.
  Future<int> insertConsultation(ConsultationsCompanion consultation) {
    return into(consultations).insert(consultation);
  }

  /// Обновить консультацию.
  Future<bool> updateConsultationById(int id, ConsultationsCompanion consultation) {
    return (update(consultations)..where((c) => c.id.equals(id)))
        .write(consultation)
        .then((rows) => rows > 0);
  }

  /// Удалить консультацию.
  Future<int> deleteConsultation(int id) {
    return (delete(consultations)..where((c) => c.id.equals(id))).go();
  }

  /// Удалить консультации пациента.
  Future<int> deleteConsultationsForPatient(int patientId) {
    return (delete(consultations)..where((c) => c.patientId.equals(patientId))).go();
  }

  /// Получить консультации на сегодня.
  Future<List<Consultation>> getTodayConsultations() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(consultations)
          ..where((c) =>
              c.scheduledAt.isBiggerOrEqualValue(startOfDay) &
              c.scheduledAt.isSmallerThanValue(endOfDay))
          ..orderBy([(c) => OrderingTerm.asc(c.scheduledAt)]))
        .get();
  }

  /// Получить консультации за период.
  Future<List<Consultation>> getConsultationsForPeriod(
    DateTime startDate,
    DateTime endDate,
  ) {
    return (select(consultations)
          ..where((c) =>
              c.scheduledAt.isBiggerOrEqualValue(startDate) &
              c.scheduledAt.isSmallerOrEqualValue(endDate))
          ..orderBy([(c) => OrderingTerm.desc(c.scheduledAt)]))
        .get();
  }

  /// Стрим всех консультаций.
  Stream<List<Consultation>> watchAllConsultations() {
    return (select(consultations)
          ..orderBy([(c) => OrderingTerm.desc(c.scheduledAt)]))
        .watch();
  }

  /// Стрим консультаций пациента.
  Stream<List<Consultation>> watchConsultationsForPatient(int patientId) {
    return (select(consultations)
          ..where((c) => c.patientId.equals(patientId))
          ..orderBy([(c) => OrderingTerm.desc(c.scheduledAt)]))
        .watch();
  }
}
