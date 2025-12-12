// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PatientsTable extends Patients with TableInfo<$PatientsTable, Patient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PatientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _middleNameMeta = const VerificationMeta(
    'middleName',
  );
  @override
  late final GeneratedColumn<String> middleName = GeneratedColumn<String>(
    'middle_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<String> birthDate = GeneratedColumn<String>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diagnosisMeta = const VerificationMeta(
    'diagnosis',
  );
  @override
  late final GeneratedColumn<String> diagnosis = GeneratedColumn<String>(
    'diagnosis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roomMeta = const VerificationMeta('room');
  @override
  late final GeneratedColumn<String> room = GeneratedColumn<String>(
    'room',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _admissionDateMeta = const VerificationMeta(
    'admissionDate',
  );
  @override
  late final GeneratedColumn<String> admissionDate = GeneratedColumn<String>(
    'admission_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _medicationsMeta = const VerificationMeta(
    'medications',
  );
  @override
  late final GeneratedColumn<String> medications = GeneratedColumn<String>(
    'medications',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergiesMeta = const VerificationMeta(
    'allergies',
  );
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
    'allergies',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mainDoctorMeta = const VerificationMeta(
    'mainDoctor',
  );
  @override
  late final GeneratedColumn<String> mainDoctor = GeneratedColumn<String>(
    'main_doctor',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mainDoctorIdMeta = const VerificationMeta(
    'mainDoctorId',
  );
  @override
  late final GeneratedColumn<String> mainDoctorId = GeneratedColumn<String>(
    'main_doctor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    firstName,
    lastName,
    middleName,
    birthDate,
    phoneNumber,
    diagnosis,
    room,
    sex,
    admissionDate,
    medications,
    allergies,
    mainDoctor,
    mainDoctorId,
    status,
    imageUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'patients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Patient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('middle_name')) {
      context.handle(
        _middleNameMeta,
        middleName.isAcceptableOrUnknown(data['middle_name']!, _middleNameMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('diagnosis')) {
      context.handle(
        _diagnosisMeta,
        diagnosis.isAcceptableOrUnknown(data['diagnosis']!, _diagnosisMeta),
      );
    } else if (isInserting) {
      context.missing(_diagnosisMeta);
    }
    if (data.containsKey('room')) {
      context.handle(
        _roomMeta,
        room.isAcceptableOrUnknown(data['room']!, _roomMeta),
      );
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('admission_date')) {
      context.handle(
        _admissionDateMeta,
        admissionDate.isAcceptableOrUnknown(
          data['admission_date']!,
          _admissionDateMeta,
        ),
      );
    }
    if (data.containsKey('medications')) {
      context.handle(
        _medicationsMeta,
        medications.isAcceptableOrUnknown(
          data['medications']!,
          _medicationsMeta,
        ),
      );
    }
    if (data.containsKey('allergies')) {
      context.handle(
        _allergiesMeta,
        allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta),
      );
    }
    if (data.containsKey('main_doctor')) {
      context.handle(
        _mainDoctorMeta,
        mainDoctor.isAcceptableOrUnknown(data['main_doctor']!, _mainDoctorMeta),
      );
    }
    if (data.containsKey('main_doctor_id')) {
      context.handle(
        _mainDoctorIdMeta,
        mainDoctorId.isAcceptableOrUnknown(
          data['main_doctor_id']!,
          _mainDoctorIdMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Patient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Patient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      middleName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}middle_name'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}birth_date'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      diagnosis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diagnosis'],
      )!,
      room: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}room'],
      ),
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      ),
      admissionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}admission_date'],
      ),
      medications: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medications'],
      ),
      allergies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies'],
      ),
      mainDoctor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_doctor'],
      ),
      mainDoctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}main_doctor_id'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PatientsTable createAlias(String alias) {
    return $PatientsTable(attachedDatabase, alias);
  }
}

class Patient extends DataClass implements Insertable<Patient> {
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
  final String? mainDoctorId;
  final String status;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
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
    this.mainDoctorId,
    required this.status,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || middleName != null) {
      map['middle_name'] = Variable<String>(middleName);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<String>(birthDate);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['diagnosis'] = Variable<String>(diagnosis);
    if (!nullToAbsent || room != null) {
      map['room'] = Variable<String>(room);
    }
    if (!nullToAbsent || sex != null) {
      map['sex'] = Variable<String>(sex);
    }
    if (!nullToAbsent || admissionDate != null) {
      map['admission_date'] = Variable<String>(admissionDate);
    }
    if (!nullToAbsent || medications != null) {
      map['medications'] = Variable<String>(medications);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || mainDoctor != null) {
      map['main_doctor'] = Variable<String>(mainDoctor);
    }
    if (!nullToAbsent || mainDoctorId != null) {
      map['main_doctor_id'] = Variable<String>(mainDoctorId);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PatientsCompanion toCompanion(bool nullToAbsent) {
    return PatientsCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      middleName: middleName == null && nullToAbsent
          ? const Value.absent()
          : Value(middleName),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      diagnosis: Value(diagnosis),
      room: room == null && nullToAbsent ? const Value.absent() : Value(room),
      sex: sex == null && nullToAbsent ? const Value.absent() : Value(sex),
      admissionDate: admissionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(admissionDate),
      medications: medications == null && nullToAbsent
          ? const Value.absent()
          : Value(medications),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      mainDoctor: mainDoctor == null && nullToAbsent
          ? const Value.absent()
          : Value(mainDoctor),
      mainDoctorId: mainDoctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(mainDoctorId),
      status: Value(status),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Patient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Patient(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      middleName: serializer.fromJson<String?>(json['middleName']),
      birthDate: serializer.fromJson<String?>(json['birthDate']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      diagnosis: serializer.fromJson<String>(json['diagnosis']),
      room: serializer.fromJson<String?>(json['room']),
      sex: serializer.fromJson<String?>(json['sex']),
      admissionDate: serializer.fromJson<String?>(json['admissionDate']),
      medications: serializer.fromJson<String?>(json['medications']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      mainDoctor: serializer.fromJson<String?>(json['mainDoctor']),
      mainDoctorId: serializer.fromJson<String?>(json['mainDoctorId']),
      status: serializer.fromJson<String>(json['status']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'middleName': serializer.toJson<String?>(middleName),
      'birthDate': serializer.toJson<String?>(birthDate),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'diagnosis': serializer.toJson<String>(diagnosis),
      'room': serializer.toJson<String?>(room),
      'sex': serializer.toJson<String?>(sex),
      'admissionDate': serializer.toJson<String?>(admissionDate),
      'medications': serializer.toJson<String?>(medications),
      'allergies': serializer.toJson<String?>(allergies),
      'mainDoctor': serializer.toJson<String?>(mainDoctor),
      'mainDoctorId': serializer.toJson<String?>(mainDoctorId),
      'status': serializer.toJson<String>(status),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Patient copyWith({
    int? id,
    String? firstName,
    String? lastName,
    Value<String?> middleName = const Value.absent(),
    Value<String?> birthDate = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    String? diagnosis,
    Value<String?> room = const Value.absent(),
    Value<String?> sex = const Value.absent(),
    Value<String?> admissionDate = const Value.absent(),
    Value<String?> medications = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<String?> mainDoctor = const Value.absent(),
    Value<String?> mainDoctorId = const Value.absent(),
    String? status,
    Value<String?> imageUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Patient(
    id: id ?? this.id,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    middleName: middleName.present ? middleName.value : this.middleName,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    diagnosis: diagnosis ?? this.diagnosis,
    room: room.present ? room.value : this.room,
    sex: sex.present ? sex.value : this.sex,
    admissionDate: admissionDate.present
        ? admissionDate.value
        : this.admissionDate,
    medications: medications.present ? medications.value : this.medications,
    allergies: allergies.present ? allergies.value : this.allergies,
    mainDoctor: mainDoctor.present ? mainDoctor.value : this.mainDoctor,
    mainDoctorId: mainDoctorId.present ? mainDoctorId.value : this.mainDoctorId,
    status: status ?? this.status,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Patient copyWithCompanion(PatientsCompanion data) {
    return Patient(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      middleName: data.middleName.present
          ? data.middleName.value
          : this.middleName,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      diagnosis: data.diagnosis.present ? data.diagnosis.value : this.diagnosis,
      room: data.room.present ? data.room.value : this.room,
      sex: data.sex.present ? data.sex.value : this.sex,
      admissionDate: data.admissionDate.present
          ? data.admissionDate.value
          : this.admissionDate,
      medications: data.medications.present
          ? data.medications.value
          : this.medications,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      mainDoctor: data.mainDoctor.present
          ? data.mainDoctor.value
          : this.mainDoctor,
      mainDoctorId: data.mainDoctorId.present
          ? data.mainDoctorId.value
          : this.mainDoctorId,
      status: data.status.present ? data.status.value : this.status,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Patient(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('middleName: $middleName, ')
          ..write('birthDate: $birthDate, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('room: $room, ')
          ..write('sex: $sex, ')
          ..write('admissionDate: $admissionDate, ')
          ..write('medications: $medications, ')
          ..write('allergies: $allergies, ')
          ..write('mainDoctor: $mainDoctor, ')
          ..write('mainDoctorId: $mainDoctorId, ')
          ..write('status: $status, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    firstName,
    lastName,
    middleName,
    birthDate,
    phoneNumber,
    diagnosis,
    room,
    sex,
    admissionDate,
    medications,
    allergies,
    mainDoctor,
    mainDoctorId,
    status,
    imageUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Patient &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.middleName == this.middleName &&
          other.birthDate == this.birthDate &&
          other.phoneNumber == this.phoneNumber &&
          other.diagnosis == this.diagnosis &&
          other.room == this.room &&
          other.sex == this.sex &&
          other.admissionDate == this.admissionDate &&
          other.medications == this.medications &&
          other.allergies == this.allergies &&
          other.mainDoctor == this.mainDoctor &&
          other.mainDoctorId == this.mainDoctorId &&
          other.status == this.status &&
          other.imageUrl == this.imageUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PatientsCompanion extends UpdateCompanion<Patient> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> middleName;
  final Value<String?> birthDate;
  final Value<String?> phoneNumber;
  final Value<String> diagnosis;
  final Value<String?> room;
  final Value<String?> sex;
  final Value<String?> admissionDate;
  final Value<String?> medications;
  final Value<String?> allergies;
  final Value<String?> mainDoctor;
  final Value<String?> mainDoctorId;
  final Value<String> status;
  final Value<String?> imageUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PatientsCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.middleName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.diagnosis = const Value.absent(),
    this.room = const Value.absent(),
    this.sex = const Value.absent(),
    this.admissionDate = const Value.absent(),
    this.medications = const Value.absent(),
    this.allergies = const Value.absent(),
    this.mainDoctor = const Value.absent(),
    this.mainDoctorId = const Value.absent(),
    this.status = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PatientsCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    this.middleName = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    required String diagnosis,
    this.room = const Value.absent(),
    this.sex = const Value.absent(),
    this.admissionDate = const Value.absent(),
    this.medications = const Value.absent(),
    this.allergies = const Value.absent(),
    this.mainDoctor = const Value.absent(),
    this.mainDoctorId = const Value.absent(),
    required String status,
    this.imageUrl = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : firstName = Value(firstName),
       lastName = Value(lastName),
       diagnosis = Value(diagnosis),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Patient> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? middleName,
    Expression<String>? birthDate,
    Expression<String>? phoneNumber,
    Expression<String>? diagnosis,
    Expression<String>? room,
    Expression<String>? sex,
    Expression<String>? admissionDate,
    Expression<String>? medications,
    Expression<String>? allergies,
    Expression<String>? mainDoctor,
    Expression<String>? mainDoctorId,
    Expression<String>? status,
    Expression<String>? imageUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (middleName != null) 'middle_name': middleName,
      if (birthDate != null) 'birth_date': birthDate,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (diagnosis != null) 'diagnosis': diagnosis,
      if (room != null) 'room': room,
      if (sex != null) 'sex': sex,
      if (admissionDate != null) 'admission_date': admissionDate,
      if (medications != null) 'medications': medications,
      if (allergies != null) 'allergies': allergies,
      if (mainDoctor != null) 'main_doctor': mainDoctor,
      if (mainDoctorId != null) 'main_doctor_id': mainDoctorId,
      if (status != null) 'status': status,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PatientsCompanion copyWith({
    Value<int>? id,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String?>? middleName,
    Value<String?>? birthDate,
    Value<String?>? phoneNumber,
    Value<String>? diagnosis,
    Value<String?>? room,
    Value<String?>? sex,
    Value<String?>? admissionDate,
    Value<String?>? medications,
    Value<String?>? allergies,
    Value<String?>? mainDoctor,
    Value<String?>? mainDoctorId,
    Value<String>? status,
    Value<String?>? imageUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PatientsCompanion(
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
      mainDoctorId: mainDoctorId ?? this.mainDoctorId,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (middleName.present) {
      map['middle_name'] = Variable<String>(middleName.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<String>(birthDate.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (diagnosis.present) {
      map['diagnosis'] = Variable<String>(diagnosis.value);
    }
    if (room.present) {
      map['room'] = Variable<String>(room.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (admissionDate.present) {
      map['admission_date'] = Variable<String>(admissionDate.value);
    }
    if (medications.present) {
      map['medications'] = Variable<String>(medications.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (mainDoctor.present) {
      map['main_doctor'] = Variable<String>(mainDoctor.value);
    }
    if (mainDoctorId.present) {
      map['main_doctor_id'] = Variable<String>(mainDoctorId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PatientsCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('middleName: $middleName, ')
          ..write('birthDate: $birthDate, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('diagnosis: $diagnosis, ')
          ..write('room: $room, ')
          ..write('sex: $sex, ')
          ..write('admissionDate: $admissionDate, ')
          ..write('medications: $medications, ')
          ..write('allergies: $allergies, ')
          ..write('mainDoctor: $mainDoctor, ')
          ..write('mainDoctorId: $mainDoctorId, ')
          ..write('status: $status, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PatientsTable patients = $PatientsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [patients];
}

typedef $$PatientsTableCreateCompanionBuilder =
    PatientsCompanion Function({
      Value<int> id,
      required String firstName,
      required String lastName,
      Value<String?> middleName,
      Value<String?> birthDate,
      Value<String?> phoneNumber,
      required String diagnosis,
      Value<String?> room,
      Value<String?> sex,
      Value<String?> admissionDate,
      Value<String?> medications,
      Value<String?> allergies,
      Value<String?> mainDoctor,
      Value<String?> mainDoctorId,
      required String status,
      Value<String?> imageUrl,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$PatientsTableUpdateCompanionBuilder =
    PatientsCompanion Function({
      Value<int> id,
      Value<String> firstName,
      Value<String> lastName,
      Value<String?> middleName,
      Value<String?> birthDate,
      Value<String?> phoneNumber,
      Value<String> diagnosis,
      Value<String?> room,
      Value<String?> sex,
      Value<String?> admissionDate,
      Value<String?> medications,
      Value<String?> allergies,
      Value<String?> mainDoctor,
      Value<String?> mainDoctorId,
      Value<String> status,
      Value<String?> imageUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PatientsTableFilterComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diagnosis => $composableBuilder(
    column: $table.diagnosis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get admissionDate => $composableBuilder(
    column: $table.admissionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainDoctor => $composableBuilder(
    column: $table.mainDoctor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mainDoctorId => $composableBuilder(
    column: $table.mainDoctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PatientsTableOrderingComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diagnosis => $composableBuilder(
    column: $table.diagnosis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get room => $composableBuilder(
    column: $table.room,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get admissionDate => $composableBuilder(
    column: $table.admissionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainDoctor => $composableBuilder(
    column: $table.mainDoctor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainDoctorId => $composableBuilder(
    column: $table.mainDoctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PatientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PatientsTable> {
  $$PatientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get middleName => $composableBuilder(
    column: $table.middleName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get diagnosis =>
      $composableBuilder(column: $table.diagnosis, builder: (column) => column);

  GeneratedColumn<String> get room =>
      $composableBuilder(column: $table.room, builder: (column) => column);

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get admissionDate => $composableBuilder(
    column: $table.admissionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get mainDoctor => $composableBuilder(
    column: $table.mainDoctor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mainDoctorId => $composableBuilder(
    column: $table.mainDoctorId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PatientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PatientsTable,
          Patient,
          $$PatientsTableFilterComposer,
          $$PatientsTableOrderingComposer,
          $$PatientsTableAnnotationComposer,
          $$PatientsTableCreateCompanionBuilder,
          $$PatientsTableUpdateCompanionBuilder,
          (Patient, BaseReferences<_$AppDatabase, $PatientsTable, Patient>),
          Patient,
          PrefetchHooks Function()
        > {
  $$PatientsTableTableManager(_$AppDatabase db, $PatientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PatientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PatientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PatientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String?> middleName = const Value.absent(),
                Value<String?> birthDate = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String> diagnosis = const Value.absent(),
                Value<String?> room = const Value.absent(),
                Value<String?> sex = const Value.absent(),
                Value<String?> admissionDate = const Value.absent(),
                Value<String?> medications = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> mainDoctor = const Value.absent(),
                Value<String?> mainDoctorId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PatientsCompanion(
                id: id,
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
                mainDoctorId: mainDoctorId,
                status: status,
                imageUrl: imageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String firstName,
                required String lastName,
                Value<String?> middleName = const Value.absent(),
                Value<String?> birthDate = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                required String diagnosis,
                Value<String?> room = const Value.absent(),
                Value<String?> sex = const Value.absent(),
                Value<String?> admissionDate = const Value.absent(),
                Value<String?> medications = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> mainDoctor = const Value.absent(),
                Value<String?> mainDoctorId = const Value.absent(),
                required String status,
                Value<String?> imageUrl = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => PatientsCompanion.insert(
                id: id,
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
                mainDoctorId: mainDoctorId,
                status: status,
                imageUrl: imageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PatientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PatientsTable,
      Patient,
      $$PatientsTableFilterComposer,
      $$PatientsTableOrderingComposer,
      $$PatientsTableAnnotationComposer,
      $$PatientsTableCreateCompanionBuilder,
      $$PatientsTableUpdateCompanionBuilder,
      (Patient, BaseReferences<_$AppDatabase, $PatientsTable, Patient>),
      Patient,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
}
