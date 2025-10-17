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
    );
    _patients.add(patient);
    _vitalsByPatient[patient.id] = [];
    notifyListeners();
    return patient;
  }

  void removePatient(int id) {
    _patients.removeWhere((p) => p.id == id);
    _vitalsByPatient.remove(id);
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
}
