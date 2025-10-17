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
  final String status; // Стабилен/Под наблюдением/Критический

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
  });

  String get fullName => [lastName, firstName, if (middleName != null && middleName!.isNotEmpty) middleName]
      .whereType<String>()
      .join(' ');
}
