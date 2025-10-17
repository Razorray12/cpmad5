import '../models/vital_sign.dart';

/// Состояние для управления жизненными показателями
class VitalState {
  final Map<int, List<VitalSign>> vitalsByPatient;
  final bool isLoading;
  final String? error;

  const VitalState({
    this.vitalsByPatient = const {},
    this.isLoading = false,
    this.error,
  });

  VitalState copyWith({
    Map<int, List<VitalSign>>? vitalsByPatient,
    bool? isLoading,
    String? error,
  }) {
    return VitalState(
      vitalsByPatient: vitalsByPatient ?? this.vitalsByPatient,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  List<VitalSign> getVitalsForPatient(int patientId) {
    return vitalsByPatient[patientId] ?? [];
  }

  VitalSign? getLatestVitalsForPatient(int patientId) {
    final vitals = getVitalsForPatient(patientId);
    if (vitals.isEmpty) return null;
    
    vitals.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return vitals.first;
  }

  int getVitalCountForPatient(int patientId) {
    return getVitalsForPatient(patientId).length;
  }

  int get totalVitalCount {
    return vitalsByPatient.values
        .fold(0, (sum, vitals) => sum + vitals.length);
  }
}
