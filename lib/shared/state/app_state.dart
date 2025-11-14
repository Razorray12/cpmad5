import 'package:mobx/mobx.dart';
import '../../features/patients/models/patient.dart';
import '../../features/vitals/models/vital_sign.dart';
import '../../features/consultations/models/consultation.dart';

part 'app_state.g.dart';

/// MobX Store приложения.
///
/// Хранит пациентов, их показатели, консультации и контекст госпитализации.
class AppState = _AppState with _$AppState;

abstract class _AppState with Store {
  int _nextId = 1;

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

  /// Текущий пациент в контексте госпитализации (горизонтальный мастер).
  @observable
  int? admissionPatientId;

  /// Количество консультаций.
  @computed
  int get consultationsCount => consultations.length;

  /// Последний добавленный пациент.
  @computed
  Patient? get lastAddedPatient {
    if (lastAddedPatientId == null) return null;
    return patients.firstWhere(
      (p) => p.id == lastAddedPatientId,
      orElse: () => const Patient(
        id: -1,
        firstName: 'Неизвестно',
        lastName: '',
        diagnosis: '',
        status: 'Неизвестно',
      ),
    );
  }

  /// ID пациента в процессе госпитализации.
  int? get admissionPatientIdSafe => admissionPatientId;

  /// Сам пациент в процессе госпитализации.
  @computed
  Patient? get admissionPatient {
    if (admissionPatientId == null) return null;
    try {
      return patients.firstWhere((p) => p.id == admissionPatientId);
    } catch (_) {
      return null;
    }
  }

  /// Набор vitals по пациенту как обычный список (read-only).
  List<VitalSign> vitalsFor(int patientId) {
    final list = vitalsByPatient[patientId];
    if (list == null) return const [];
    return List.unmodifiable(list);
  }

  /// Все консультации как read-only список.
  List<Consultation> get consultationsReadOnly =>
      List.unmodifiable(consultations);

  /// Установить текущего пациента в мастере госпитализации.
  @action
  void setAdmissionPatientId(int id) {
    admissionPatientId = id;
  }

  /// Очистить контекст госпитализации.
  @action
  void clearAdmission() {
    admissionPatientId = null;
  }

  /// Добавить пациента.
  @action
  Patient addPatient({
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
    required String status,
    String? imageUrl,
  }) {
    final patient = Patient(
      id: _nextId++,
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
    patients.add(patient);
    vitalsByPatient[patient.id] = ObservableList<VitalSign>();
    lastAddedPatientId = patient.id;
    return patient;
  }

  /// Удалить пациента и связанные данные.
  @action
  void removePatient(int id) {
    patients.removeWhere((p) => p.id == id);
    vitalsByPatient.remove(id);
    consultations.removeWhere((c) => c.patientId == id);
    if (admissionPatientId == id) {
      admissionPatientId = null;
    }
  }

  /// Добавить vitals пациенту.
  @action
  void addVital(int patientId, VitalSign vital) {
    final list =
        vitalsByPatient.putIfAbsent(patientId, () => ObservableList<VitalSign>());
    list.add(vital);
  }

  /// Удалить vitals у пациента.
  @action
  void removeVital(int patientId, VitalSign vital) {
    final list = vitalsByPatient[patientId];
    list?.remove(vital);
  }

  /// Добавить консультацию.
  @action
  void addConsultation(Consultation c) {
    consultations.add(c);
  }

  /// Удалить консультацию.
  @action
  void removeConsultation(Consultation consultation) {
    consultations.remove(consultation);
  }

  /// Обновить данные пациента.
  @action
  void updatePatient(Patient updatedPatient) {
    final index = patients.indexWhere((p) => p.id == updatedPatient.id);
    if (index != -1) {
      patients[index] = updatedPatient;
    }
  }

  /// Обновить консультацию.
  @action
  void updateConsultation(Consultation updatedConsultation) {
    final index = consultations.indexWhere((c) => c == updatedConsultation);
    if (index != -1) {
      consultations[index] = updatedConsultation;
    }
  }

  /// Поиск пациентов по имени/диагнозу/палате.
  List<Patient> searchPatients(String query) {
    if (query.isEmpty) return patients.toList(growable: false);
    final lowerQuery = query.toLowerCase();
    return patients.where((patient) {
      return patient.fullName.toLowerCase().contains(lowerQuery) ||
          patient.diagnosis.toLowerCase().contains(lowerQuery) ||
          (patient.room?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  /// Консультации по конкретному пациенту.
  List<Consultation> consultationsForPatient(int patientId) {
    return consultations.where((c) => c.patientId == patientId).toList();
  }

  /// Инициализация тестовых данных.
  @action
  void initializeSampleData() {
    try {
      // Добавляем тестовых пациентов с сетевыми изображениями
      addPatient(
        firstName: 'Анна',
        lastName: 'Петрова',
        middleName: 'Сергеевна',
        birthDate: '1985-03-15',
        phoneNumber: '+7-912-345-67-89',
        diagnosis: 'Гипертоническая болезнь II степени',
        room: '101',
        sex: 'Женский',
        admissionDate: '2024-01-15',
        medications: 'Эналаприл 5мг, Амлодипин 5мг',
        allergies: 'Пенициллин',
        mainDoctor: 'Иванов И.И.',
        mainDoctorID: 'DOC001',
        status: 'Стабилен',
        imageUrl: 'https://randomuser.me/api/portraits/men/30.jpg',
      );

      addPatient(
        firstName: 'Михаил',
        lastName: 'Сидоров',
        middleName: 'Александрович',
        birthDate: '1978-07-22',
        phoneNumber: '+7-923-456-78-90',
        diagnosis: 'Сахарный диабет 2 типа',
        room: '205',
        sex: 'Мужской',
        admissionDate: '2024-01-20',
        medications: 'Метформин 1000мг, Глибенкламид 5мг',
        allergies: 'Сульфаниламиды',
        mainDoctor: 'Петрова А.А.',
        mainDoctorID: 'DOC002',
        status: 'Под наблюдением',
        imageUrl: 'https://randomuser.me/api/portraits/women/51.jpg',
      );

      addPatient(
        firstName: 'Елена',
        lastName: 'Козлова',
        middleName: 'Владимировна',
        birthDate: '1992-11-08',
        phoneNumber: '+7-934-567-89-01',
        diagnosis: 'Бронхиальная астма',
        room: '312',
        sex: 'Женский',
        admissionDate: '2024-01-25',
        medications: 'Сальбутамол, Беклометазон',
        allergies: 'Пыльца растений',
        mainDoctor: 'Смирнов В.В.',
        mainDoctorID: 'DOC003',
        status: 'Под наблюдением',
        imageUrl: 'https://randomuser.me/api/portraits/women/92.jpg',
      );

      addPatient(
        firstName: 'Дмитрий',
        lastName: 'Морозов',
        middleName: 'Игоревич',
        birthDate: '1980-05-14',
        phoneNumber: '+7-945-678-90-12',
        diagnosis: 'Ишемическая болезнь сердца',
        room: '108',
        sex: 'Мужской',
        admissionDate: '2024-01-28',
        medications: 'Аспирин 75мг, Аторвастатин 20мг',
        allergies: 'Нет',
        mainDoctor: 'Кузнецова Н.Н.',
        mainDoctorID: 'DOC004',
        status: 'Стабилен',
        imageUrl: 'https://randomuser.me/api/portraits/men/57.jpg',
      );

      addPatient(
        firstName: 'Ольга',
        lastName: 'Новикова',
        middleName: 'Петровна',
        birthDate: '1975-12-03',
        phoneNumber: '+7-956-789-01-23',
        diagnosis: 'Хронический гастрит',
        room: '401',
        sex: 'Женский',
        admissionDate: '2024-02-01',
        medications: 'Омепразол 20мг, Домперидон 10мг',
        allergies: 'Лактоза',
        mainDoctor: 'Волкова С.С.',
        mainDoctorID: 'DOC005',
        status: 'Под наблюдением',
        imageUrl: 'https://randomuser.me/api/portraits/women/77.jpg',
      );
      // ignore: avoid_print
      print('Тестовые данные успешно инициализированы');
    } catch (e) {
      // ignore: avoid_print
      print('Ошибка при инициализации тестовых данных: $e');
    }
  }

  /// Полная очистка данных.
  @action
  void clearAllData() {
    patients.clear();
    vitalsByPatient.clear();
    consultations.clear();
    _nextId = 1;
    lastAddedPatientId = null;
    admissionPatientId = null;
    // ignore: avoid_print
    print('Все данные очищены');
  }
}
