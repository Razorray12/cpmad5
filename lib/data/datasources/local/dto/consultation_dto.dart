/// DTO структура консультации.
class ConsultationDTO {
  final int? id;
  final int patientId;
  final String dateTime;
  final String? doctorId;
  final String? doctorName;
  final String note;
  final String type;

  const ConsultationDTO({
    this.id,
    required this.patientId,
    required this.dateTime,
    this.doctorId,
    this.doctorName,
    required this.note,
    this.type = 'regular',
  });

  factory ConsultationDTO.fromJson(Map<String, dynamic> json) {
    return ConsultationDTO(
      id: json['id'] as int?,
      patientId: json['patientId'] as int,
      dateTime: json['dateTime'] as String,
      doctorId: json['doctorId'] as String?,
      doctorName: json['doctorName'] as String?,
      note: json['note'] as String,
      type: json['type'] as String? ?? 'regular',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'dateTime': dateTime,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'note': note,
      'type': type,
    };
  }
}

