import 'package:mobx/mobx.dart';
import '../../core/models/models.dart';
import '../../domain/usecases/patient/get_patients_usecase.dart';
import '../../domain/usecases/patient/manage_patient_usecase.dart';
import '../../domain/usecases/vitals/vitals_usecases.dart';
import '../../domain/usecases/consultation/consultation_usecases.dart';

part 'app_state.g.dart';

/// MobX Store приложения.
/// 
/// Использует репозитории для доступа к данным,
/// следуя принципам Clean Architecture.
class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  final GetPatientsUseCase getPatientsUseCase;
  final SearchPatientsUseCase searchPatientsUseCase;
  final AddPatientUseCase addPatientUseCase;
  final UpdatePatientUseCase updatePatientUseCase;
  final DeletePatientUseCase deletePatientUseCase;

  final GetVitalsUseCase getVitalsUseCase;
  final GetLatestVitalsUseCase getLatestVitalsUseCase;
  final AddVitalsUseCase addVitalsUseCase;
  final DeleteVitalsUseCase deleteVitalsUseCase;

  final GetConsultationsUseCase getConsultationsUseCase;
  final AddConsultationUseCase addConsultationUseCase;
  final UpdateConsultationUseCase updateConsultationUseCase;
  final DeleteConsultationUseCase deleteConsultationUseCase;

  _AppState({
    required this.getPatientsUseCase,
    required this.searchPatientsUseCase,
    required this.addPatientUseCase,
    required this.updatePatientUseCase,
    required this.deletePatientUseCase,
    required this.getVitalsUseCase,
    required this.getLatestVitalsUseCase,
    required this.addVitalsUseCase,
    required this.deleteVitalsUseCase,
    required this.getConsultationsUseCase,
    required this.addConsultationUseCase,
    required this.updateConsultationUseCase,
    required this.deleteConsultationUseCase,
  });

  /// Все пациенты.
  @observable
  ObservableList<Patient> patients = ObservableList<Patient>();

  /// Показатели жизнедеятельности по пациенту.
  @observable
  ObservableMap<int, ObservableList<VitalSign>> vitalsByPatient =
      ObservableMap<int, ObservableList<VitalSign>>();

  /// Все консультации.
  @observable
  ObservableList<Consultation> consultations = ObservableList<Consultation>();

  /// ID последнего добавленного пациента.
  @observable
  int? lastAddedPatientId;

  /// Текущий пациент в контексте госпитализации.
  @observable
  int? admissionPatientId;

  /// Флаг загрузки.
  @observable
  bool isLoading = false;

  /// Сообщение об ошибке.
  @observable
  String? error;

  /// Количество консультаций.
  @computed
  int get consultationsCount => consultations.length;

  /// Последний добавленный пациент.
  @computed
  Patient? get lastAddedPatient {
    if (lastAddedPatientId == null) return null;
    try {
      return patients.firstWhere((p) => p.id == lastAddedPatientId);
    } catch (_) {
      return null;
    }
  }

  /// Пациент в процессе госпитализации.
  @computed
  Patient? get admissionPatient {
    if (admissionPatientId == null) return null;
    try {
      return patients.firstWhere((p) => p.id == admissionPatientId);
    } catch (_) {
      return null;
    }
  }

  /// Показатели пациента как read-only список.
  List<VitalSign> vitalsFor(int patientId) {
    final list = vitalsByPatient[patientId];
    if (list == null) return const [];
    return List.unmodifiable(list);
  }

  /// Все консультации как read-only список.
  List<Consultation> get consultationsReadOnly =>
      List.unmodifiable(consultations);

  /// Установить контекст госпитализации.
  @action
  void setAdmissionPatientId(int id) {
    admissionPatientId = id;
  }

  /// Очистить контекст госпитализации.
  @action
  void clearAdmission() {
    admissionPatientId = null;
  }

  /// Загрузить данные из репозиториев.
  @action
  Future<void> loadData() async {
    isLoading = true;
    error = null;
    try {
      final loadedPatients = await getPatientsUseCase.execute();
      patients.clear();
      patients.addAll(loadedPatients);

      final loadedConsultations = await getConsultationsUseCase.execute();
      consultations.clear();
      consultations.addAll(loadedConsultations);

      for (final patient in loadedPatients) {
        final vitals = await getVitalsUseCase.execute(patient.id);
        vitalsByPatient[patient.id] = ObservableList.of(vitals);
      }
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  /// Добавить пациента.
  @action
  Future<Patient> addPatient({
    required String firstName,
    required String lastName,
    String? middleName,
    String? birthDate,
    String? phoneNumber,
    required String diagnosis,
    String? room,
    String? sex,
    String? admissionDate,
    String? medications,
    String? allergies,
    String? mainDoctor,
    String? mainDoctorID,
    required PatientStatus status,
    String? imageUrl,
  }) async {
    final addedPatient = await addPatientUseCase.execute(
      firstName: firstName,
      lastName: lastName,
      middleName: middleName,
      birthDate: birthDate,
      phoneNumber: phoneNumber,
      diagnosis: diagnosis,
      room: room,
      sex: sex,
      admissionDate: admissionDate,
      medications: medications,
      allergies: allergies,
      mainDoctor: mainDoctor,
      mainDoctorID: mainDoctorID,
      status: status,
      imageUrl: imageUrl,
    );
    patients.add(addedPatient);
    vitalsByPatient[addedPatient.id] = ObservableList<VitalSign>();
    lastAddedPatientId = addedPatient.id;
    return addedPatient;
  }

  /// Удалить пациента и связанные данные.
  @action
  Future<void> removePatient(int id) async {
    await deletePatientUseCase.execute(id);

    patients.removeWhere((p) => p.id == id);
    vitalsByPatient.remove(id);
    consultations.removeWhere((c) => c.patientId == id);
    if (admissionPatientId == id) {
      admissionPatientId = null;
    }
  }

  /// Обновить данные пациента.
  @action
  Future<void> updatePatient(Patient updatedPatient) async {
    await updatePatientUseCase.execute(updatedPatient);
    final index = patients.indexWhere((p) => p.id == updatedPatient.id);
    if (index != -1) {
      patients[index] = updatedPatient;
    }
  }

  /// Добавить показатели пациенту.
  @action
  Future<void> addVital(int patientId, VitalSign vital) async {
    final addedVital = await addVitalsUseCase.execute(
      patientId: patientId,
      temperature: vital.temperature,
      heartRate: vital.heartRate,
      respiratoryRate: vital.respiratoryRate,
      bloodPressure: vital.bloodPressure,
      oxygenSaturation: vital.oxygenSaturation,
      bloodGlucose: vital.bloodGlucose,
    );
    final list = vitalsByPatient.putIfAbsent(
      patientId,
      () => ObservableList<VitalSign>(),
    );
    list.add(addedVital);
  }

  /// Удалить показатели у пациента.
  @action
  Future<void> removeVital(int patientId, VitalSign vital) async {
    if (vital.id != null) {
      await deleteVitalsUseCase.execute(vital.id!);
    }
    final list = vitalsByPatient[patientId];
    list?.remove(vital);
  }

  /// Добавить консультацию.
  @action
  Future<void> addConsultation(Consultation c) async {
    final added = await addConsultationUseCase.execute(
      patientId: c.patientId,
      dateTime: c.dateTime,
      doctorId: c.doctorId,
      doctorName: c.doctorName,
      note: c.note,
      type: c.type,
    );
    consultations.add(added);
  }

  /// Удалить консультацию.
  @action
  Future<void> removeConsultation(Consultation consultation) async {
    if (consultation.id != null) {
      await deleteConsultationUseCase.execute(consultation.id!);
    }
    consultations.remove(consultation);
  }

  /// Обновить консультацию.
  @action
  Future<void> updateConsultation(Consultation updatedConsultation) async {
    await updateConsultationUseCase.execute(updatedConsultation);
    final index = consultations.indexWhere((c) => c.id == updatedConsultation.id);
    if (index != -1) {
      consultations[index] = updatedConsultation;
    }
  }

  /// Поиск пациентов.
  Future<List<Patient>> searchPatients(String query) async {
    if (query.isEmpty) return patients.toList();
    return searchPatientsUseCase.execute(query);
  }

  /// Консультации по конкретному пациенту.
  List<Consultation> consultationsForPatient(int patientId) {
    return consultations.where((c) => c.patientId == patientId).toList();
  }

  /// Полная очистка данных.
  @action
  void clearAllData() {
    patients.clear();
    vitalsByPatient.clear();
    consultations.clear();
    lastAddedPatientId = null;
    admissionPatientId = null;
  }
}

