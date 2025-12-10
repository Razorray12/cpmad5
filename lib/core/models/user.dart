/// Бизнес-модель пользователя (врач).
class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? middleName;
  final String? specialization;
  final String? department;
  final String? phoneNumber;
  final String? avatarUrl;
  final DateTime? createdAt;

  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.middleName,
    this.specialization,
    this.department,
    this.phoneNumber,
    this.avatarUrl,
    this.createdAt,
  });

  /// Полное имя (ФИО).
  String get fullName {
    if (middleName != null && middleName!.isNotEmpty) {
      return '$lastName $firstName $middleName';
    }
    return '$lastName $firstName';
  }

  /// Инициалы.
  String get initials {
    final first = firstName.isNotEmpty ? firstName[0] : '';
    final last = lastName.isNotEmpty ? lastName[0] : '';
    return '$first$last'.toUpperCase();
  }

  /// Краткое имя для отображения (Фамилия И.О.).
  String get shortName {
    final firstInitial = firstName.isNotEmpty ? '${firstName[0]}.' : '';
    final middleInitial =
        middleName != null && middleName!.isNotEmpty ? '${middleName![0]}.' : '';
    return '$lastName $firstInitial$middleInitial';
  }

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? middleName,
    String? specialization,
    String? department,
    String? phoneNumber,
    String? avatarUrl,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      middleName: middleName ?? this.middleName,
      specialization: specialization ?? this.specialization,
      department: department ?? this.department,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

