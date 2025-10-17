class Consultation {
  final int patientId;
  final DateTime dateTime;
  final String? doctorName;
  final String note;

  const Consultation({
    required this.patientId,
    required this.dateTime,
    this.doctorName,
    required this.note,
  });
}

