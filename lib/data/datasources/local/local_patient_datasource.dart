import 'dart:async';
import '../../../core/models/patient.dart';
import 'dto/patient_dto.dart';
import 'mappers/patient_mapper.dart';

/// Локальный источник данных для пациентов (in-memory).
/// Инкапсулирует работу с локальным хранилищем и преобразование данных.
class LocalPatientDataSource {
  final List<PatientDTO> _patients = [];
  int _nextId = 1;

  final _patientsController = StreamController<List<Patient>>.broadcast();

  /// Стрим изменений пациентов.
  Stream<List<Patient>> get patientsStream => _patientsController.stream;

  /// Получить всех пациентов.
  Future<List<Patient>> getAll() async {
    return _patients.map((dto) => dto.toModel()).toList();
  }

  /// Получить пациента по ID.
  Future<Patient?> getById(int id) async {
    try {
      final dto = _patients.firstWhere((p) => p.id == id);
      return dto.toModel();
    } catch (_) {
      return null;
    }
  }

  /// Добавить пациента.
  Future<Patient> add(Patient patient) async {
    final dto = PatientDTO(
      id: _nextId++,
      firstName: patient.firstName,
      lastName: patient.lastName,
      middleName: patient.middleName,
      birthDate: patient.birthDate,
      phoneNumber: patient.phoneNumber,
      diagnosis: patient.diagnosis,
      room: patient.room,
      sex: patient.sex,
      admissionDate: patient.admissionDate,
      medications: patient.medications,
      allergies: patient.allergies,
      mainDoctor: patient.mainDoctor,
      mainDoctorID: patient.mainDoctorID,
      status: patient.status.displayName,
      imageUrl: patient.imageUrl,
    );
    _patients.add(dto);
    _notifyListeners();
    return dto.toModel();
  }

  /// Обновить пациента.
  Future<Patient> update(Patient patient) async {
    final index = _patients.indexWhere((p) => p.id == patient.id);
    if (index != -1) {
      final dto = patient.toDTO();
      _patients[index] = dto;
      _notifyListeners();
      return dto.toModel();
    }
    throw Exception('Пациент не найден');
  }

  /// Удалить пациента.
  Future<void> delete(int id) async {
    _patients.removeWhere((p) => p.id == id);
    _notifyListeners();
  }

  /// Поиск пациентов.
  Future<List<Patient>> search(String query) async {
    if (query.isEmpty) return getAll();
    final lowerQuery = query.toLowerCase();
    return _patients
        .where((dto) =>
            dto.firstName.toLowerCase().contains(lowerQuery) ||
            dto.lastName.toLowerCase().contains(lowerQuery) ||
            dto.diagnosis.toLowerCase().contains(lowerQuery) ||
            (dto.room?.toLowerCase().contains(lowerQuery) ?? false))
        .map((dto) => dto.toModel())
        .toList();
  }

  /// Получить пациентов по статусу.
  Future<List<Patient>> getByStatus(PatientStatus status) async {
    return _patients
        .where((dto) => dto.status == status.displayName)
        .map((dto) => dto.toModel())
        .toList();
  }

  /// Инициализация тестовых данных.
  Future<void> initializeSampleData() async {
    final samplePatients = [
      Patient(
        id: 0,
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
        status: PatientStatus.stable,
        imageUrl: 'https://randomuser.me/api/portraits/men/30.jpg',
      ),
      Patient(
        id: 0,
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
        status: PatientStatus.observation,
        imageUrl: 'https://randomuser.me/api/portraits/women/51.jpg',
      ),
      Patient(
        id: 0,
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
        status: PatientStatus.observation,
        imageUrl: 'https://randomuser.me/api/portraits/women/92.jpg',
      ),
      Patient(
        id: 0,
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
        status: PatientStatus.stable,
        imageUrl: 'https://randomuser.me/api/portraits/men/57.jpg',
      ),
      Patient(
        id: 0,
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
        status: PatientStatus.observation,
        imageUrl: 'https://randomuser.me/api/portraits/women/77.jpg',
      ),
    ];

    for (final patient in samplePatients) {
      await add(patient);
    }
  }

  void _notifyListeners() {
    _patientsController.add(_patients.map((dto) => dto.toModel()).toList());
  }

  void dispose() {
    _patientsController.close();
  }
}

