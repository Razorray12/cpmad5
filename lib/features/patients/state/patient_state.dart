import '../models/patient.dart';

/// Состояние для управления пациентами
class PatientState {
  final List<Patient> patients;
  final bool isLoading;
  final String? error;

  const PatientState({
    this.patients = const [],
    this.isLoading = false,
    this.error,
  });

  PatientState copyWith({
    List<Patient>? patients,
    bool? isLoading,
    String? error,
  }) {
    return PatientState(
      patients: patients ?? this.patients,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  Patient? getPatientById(int id) {
    try {
      return patients.firstWhere((patient) => patient.id == id);
    } catch (e) {
      return null;
    }
  }

  List<Patient> getPatientsByStatus(String status) {
    return patients.where((patient) => patient.status == status).toList();
  }

  int getPatientCountByStatus(String status) {
    return patients.where((patient) => patient.status == status).length;
  }
}
