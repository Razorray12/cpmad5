/// Бизнес-модель консультации.
class Consultation {
  final int? id;
  final int patientId;
  final DateTime dateTime;
  final String? doctorId;
  final String? doctorName;
  final String note;
  final ConsultationType type;

  const Consultation({
    this.id,
    required this.patientId,
    required this.dateTime,
    this.doctorId,
    this.doctorName,
    required this.note,
    this.type = ConsultationType.regular,
  });

  /// Проверка, была ли консультация сегодня.
  bool get isToday {
    final now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  /// Проверка, прошла ли консультация.
  bool get isPast => dateTime.isBefore(DateTime.now());

  Consultation copyWith({
    int? id,
    int? patientId,
    DateTime? dateTime,
    String? doctorId,
    String? doctorName,
    String? note,
    ConsultationType? type,
  }) {
    return Consultation(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      dateTime: dateTime ?? this.dateTime,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      note: note ?? this.note,
      type: type ?? this.type,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Consultation &&
          runtimeType == other.runtimeType &&
          patientId == other.patientId &&
          dateTime == other.dateTime &&
          note == other.note;

  @override
  int get hashCode => Object.hash(patientId, dateTime, note);
}

/// Тип консультации.
enum ConsultationType {
  regular('Плановая'),
  urgent('Экстренная'),
  followUp('Контрольная'),
  initial('Первичная');

  final String displayName;
  const ConsultationType(this.displayName);

  static ConsultationType fromString(String value) {
    return ConsultationType.values.firstWhere(
      (type) => type.displayName == value || type.name == value,
      orElse: () => ConsultationType.regular,
    );
  }
}

