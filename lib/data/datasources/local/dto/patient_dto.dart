/// DTO структура пациента для локального хранилища.
/// Инкапсулирует формат данных в конкретном источнике.
class PatientDTO {
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
  final String status;
  final String? imageUrl;

  const PatientDTO({
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

  /// Создание из JSON (для API или локального хранилища).
  factory PatientDTO.fromJson(Map<String, dynamic> json) {
    return PatientDTO(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      middleName: json['middleName'] as String?,
      birthDate: json['birthDate'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      diagnosis: json['diagnosis'] as String,
      room: json['room'] as String?,
      sex: json['sex'] as String?,
      admissionDate: json['admissionDate'] as String?,
      medications: json['medications'] as String?,
      allergies: json['allergies'] as String?,
      mainDoctor: json['mainDoctor'] as String?,
      mainDoctorID: json['mainDoctorID'] as String?,
      status: json['status'] as String,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  /// Преобразование в JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'middleName': middleName,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'diagnosis': diagnosis,
      'room': room,
      'sex': sex,
      'admissionDate': admissionDate,
      'medications': medications,
      'allergies': allergies,
      'mainDoctor': mainDoctor,
      'mainDoctorID': mainDoctorID,
      'status': status,
      'imageUrl': imageUrl,
    };
  }
}

