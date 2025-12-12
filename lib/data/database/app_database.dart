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

// ============================================
// БАЗА ДАННЫХ
// ============================================

@DriftDatabase(tables: [Patients])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // Для веб-платформы нужны WASM файлы
    return driftDatabase(
      name: 'medical_app.db',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
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
}
