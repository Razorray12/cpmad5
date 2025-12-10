/// Бизнес-модель пациента.
/// Находится в ядре приложения и не зависит от внешних технологий.
class Patient {
  final int id;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? birthDate;
  final String? phoneNumber;
  final String diagnosis;
  final String? room;
  final String? sex;
  final String? admissionDate;
  final String? medications;
  final String? allergies;
  final String? mainDoctor;
  final String? mainDoctorID;
  final PatientStatus status;
  final String? imageUrl;

  const Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.birthDate,
    this.phoneNumber,
    required this.diagnosis,
    this.room,
    this.sex,
    this.admissionDate,
    this.medications,
    this.allergies,
    this.mainDoctor,
    this.mainDoctorID,
    required this.status,
    this.imageUrl,
  });

  /// Полное имя пациента (ФИО).
  String get fullName => [
        lastName,
        firstName,
        if (middleName != null && middleName!.isNotEmpty) middleName
      ].whereType<String>().join(' ');

  /// Возраст пациента (если указана дата рождения).
  int? get age {
    if (birthDate == null) return null;
    try {
      final birth = DateTime.parse(birthDate!);
      final now = DateTime.now();
      int age = now.year - birth.year;
      if (now.month < birth.month ||
          (now.month == birth.month && now.day < birth.day)) {
        age--;
      }
      return age;
    } catch (_) {
      return null;
    }
  }

  /// Проверка критического статуса.
  bool get isCritical => status == PatientStatus.critical;

  /// Копирование с изменениями.
  Patient copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? middleName,
    String? birthDate,
    String? phoneNumber,
    String? diagnosis,
    String? room,
    String? sex,
    String? admissionDate,
    String? medications,
    String? allergies,
    String? mainDoctor,
    String? mainDoctorID,
    PatientStatus? status,
    String? imageUrl,
  }) {
    return Patient(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      birthDate: birthDate ?? this.birthDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      diagnosis: diagnosis ?? this.diagnosis,
      room: room ?? this.room,
      sex: sex ?? this.sex,
      admissionDate: admissionDate ?? this.admissionDate,
      medications: medications ?? this.medications,
      allergies: allergies ?? this.allergies,
      mainDoctor: mainDoctor ?? this.mainDoctor,
      mainDoctorID: mainDoctorID ?? this.mainDoctorID,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Patient && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

/// Статус пациента.
enum PatientStatus {
  stable('Стабилен'),
  observation('Под наблюдением'),
  critical('Критический');

  final String displayName;
  const PatientStatus(this.displayName);

  /// Преобразование из строки.
  static PatientStatus fromString(String value) {
    return PatientStatus.values.firstWhere(
      (status) => status.displayName == value,
      orElse: () => PatientStatus.stable,
    );
  }
}

