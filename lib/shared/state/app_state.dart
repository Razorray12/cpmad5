import 'package:flutter/foundation.dart';
import '../../features/patients/models/patient.dart';
import '../../features/vitals/models/vital_sign.dart';
import '../../features/consultations/models/consultation.dart';

class AppState extends ChangeNotifier {
  int _nextId = 1;
  final List<Patient> _patients = [];
  final Map<int, List<VitalSign>> _vitalsByPatient = {};
  final List<Consultation> _consultations = [];

  List<Patient> get patients => List.unmodifiable(_patients);

  List<VitalSign> vitalsFor(int patientId) =>
      List.unmodifiable(_vitalsByPatient[patientId] ?? const []);

  List<Consultation> get consultations => List.unmodifiable(_consultations);
  int get consultationsCount => _consultations.length;

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
    _patients.add(patient);
    _vitalsByPatient[patient.id] = [];
    notifyListeners();
    return patient;
  }

  void removePatient(int id) {
    _patients.removeWhere((p) => p.id == id);
    _vitalsByPatient.remove(id);
    _consultations.removeWhere((c) => c.patientId == id);
    notifyListeners();
  }

  void addVital(int patientId, VitalSign vital) {
    final list = _vitalsByPatient.putIfAbsent(patientId, () => []);
    list.add(vital);
    notifyListeners();
  }

  void addConsultation(Consultation c) {
    _consultations.add(c);
    notifyListeners();
  }

  void removeVital(int patientId, VitalSign vital) {
    final list = _vitalsByPatient[patientId];
    if (list != null) {
      list.remove(vital);
      notifyListeners();
    }
  }

  void removeConsultation(Consultation consultation) {
    _consultations.remove(consultation);
    notifyListeners();
  }

  void updatePatient(Patient updatedPatient) {
    final index = _patients.indexWhere((p) => p.id == updatedPatient.id);
    if (index != -1) {
      _patients[index] = updatedPatient;
      notifyListeners();
    }
  }

  void updateConsultation(Consultation updatedConsultation) {
    final index = _consultations.indexWhere((c) => c == updatedConsultation);
    if (index != -1) {
      _consultations[index] = updatedConsultation;
      notifyListeners();
    }
  }

  List<Patient> searchPatients(String query) {
    if (query.isEmpty) return patients;
    final lowerQuery = query.toLowerCase();
    return _patients.where((patient) {
      return patient.fullName.toLowerCase().contains(lowerQuery) ||
             patient.diagnosis.toLowerCase().contains(lowerQuery) ||
             (patient.room?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  List<Consultation> consultationsForPatient(int patientId) {
    return _consultations.where((c) => c.patientId == patientId).toList();
  }

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
    print('Тестовые данные успешно инициализированы');
    } catch (e) {
      print('Ошибка при инициализации тестовых данных: $e');
    }
  }

  void clearAllData() {
    _patients.clear();
    _vitalsByPatient.clear();
    _consultations.clear();
    _nextId = 1;
    notifyListeners();
    print('Все данные очищены');
  }
}
