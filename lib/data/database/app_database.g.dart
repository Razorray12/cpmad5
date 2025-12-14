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

class $VitalSignsTable extends VitalSigns
    with TableInfo<$VitalSignsTable, VitalSign> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VitalSignsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patients (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temperatureMeta = const VerificationMeta(
    'temperature',
  );
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
    'temperature',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heartRateMeta = const VerificationMeta(
    'heartRate',
  );
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
    'heart_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _respiratoryRateMeta = const VerificationMeta(
    'respiratoryRate',
  );
  @override
  late final GeneratedColumn<int> respiratoryRate = GeneratedColumn<int>(
    'respiratory_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodPressureMeta = const VerificationMeta(
    'bloodPressure',
  );
  @override
  late final GeneratedColumn<String> bloodPressure = GeneratedColumn<String>(
    'blood_pressure',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oxygenSaturationMeta = const VerificationMeta(
    'oxygenSaturation',
  );
  @override
  late final GeneratedColumn<int> oxygenSaturation = GeneratedColumn<int>(
    'oxygen_saturation',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodGlucoseMeta = const VerificationMeta(
    'bloodGlucose',
  );
  @override
  late final GeneratedColumn<double> bloodGlucose = GeneratedColumn<double>(
    'blood_glucose',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    patientId,
    timestamp,
    temperature,
    heartRate,
    respiratoryRate,
    bloodPressure,
    oxygenSaturation,
    bloodGlucose,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vital_signs';
  @override
  VerificationContext validateIntegrity(
    Insertable<VitalSign> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
        _temperatureMeta,
        temperature.isAcceptableOrUnknown(
          data['temperature']!,
          _temperatureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('heart_rate')) {
      context.handle(
        _heartRateMeta,
        heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta),
      );
    } else if (isInserting) {
      context.missing(_heartRateMeta);
    }
    if (data.containsKey('respiratory_rate')) {
      context.handle(
        _respiratoryRateMeta,
        respiratoryRate.isAcceptableOrUnknown(
          data['respiratory_rate']!,
          _respiratoryRateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_respiratoryRateMeta);
    }
    if (data.containsKey('blood_pressure')) {
      context.handle(
        _bloodPressureMeta,
        bloodPressure.isAcceptableOrUnknown(
          data['blood_pressure']!,
          _bloodPressureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bloodPressureMeta);
    }
    if (data.containsKey('oxygen_saturation')) {
      context.handle(
        _oxygenSaturationMeta,
        oxygenSaturation.isAcceptableOrUnknown(
          data['oxygen_saturation']!,
          _oxygenSaturationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_oxygenSaturationMeta);
    }
    if (data.containsKey('blood_glucose')) {
      context.handle(
        _bloodGlucoseMeta,
        bloodGlucose.isAcceptableOrUnknown(
          data['blood_glucose']!,
          _bloodGlucoseMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VitalSign map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VitalSign(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}patient_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      temperature: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperature'],
      )!,
      heartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate'],
      )!,
      respiratoryRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}respiratory_rate'],
      )!,
      bloodPressure: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_pressure'],
      )!,
      oxygenSaturation: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}oxygen_saturation'],
      )!,
      bloodGlucose: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}blood_glucose'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $VitalSignsTable createAlias(String alias) {
    return $VitalSignsTable(attachedDatabase, alias);
  }
}

class VitalSign extends DataClass implements Insertable<VitalSign> {
  final int id;
  final int patientId;
  final DateTime timestamp;
  final double temperature;
  final int heartRate;
  final int respiratoryRate;
  final String bloodPressure;
  final int oxygenSaturation;
  final double? bloodGlucose;
  final DateTime createdAt;
  const VitalSign({
    required this.id,
    required this.patientId,
    required this.timestamp,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
    required this.bloodPressure,
    required this.oxygenSaturation,
    this.bloodGlucose,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['temperature'] = Variable<double>(temperature);
    map['heart_rate'] = Variable<int>(heartRate);
    map['respiratory_rate'] = Variable<int>(respiratoryRate);
    map['blood_pressure'] = Variable<String>(bloodPressure);
    map['oxygen_saturation'] = Variable<int>(oxygenSaturation);
    if (!nullToAbsent || bloodGlucose != null) {
      map['blood_glucose'] = Variable<double>(bloodGlucose);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VitalSignsCompanion toCompanion(bool nullToAbsent) {
    return VitalSignsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      timestamp: Value(timestamp),
      temperature: Value(temperature),
      heartRate: Value(heartRate),
      respiratoryRate: Value(respiratoryRate),
      bloodPressure: Value(bloodPressure),
      oxygenSaturation: Value(oxygenSaturation),
      bloodGlucose: bloodGlucose == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodGlucose),
      createdAt: Value(createdAt),
    );
  }

  factory VitalSign.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VitalSign(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      temperature: serializer.fromJson<double>(json['temperature']),
      heartRate: serializer.fromJson<int>(json['heartRate']),
      respiratoryRate: serializer.fromJson<int>(json['respiratoryRate']),
      bloodPressure: serializer.fromJson<String>(json['bloodPressure']),
      oxygenSaturation: serializer.fromJson<int>(json['oxygenSaturation']),
      bloodGlucose: serializer.fromJson<double?>(json['bloodGlucose']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'temperature': serializer.toJson<double>(temperature),
      'heartRate': serializer.toJson<int>(heartRate),
      'respiratoryRate': serializer.toJson<int>(respiratoryRate),
      'bloodPressure': serializer.toJson<String>(bloodPressure),
      'oxygenSaturation': serializer.toJson<int>(oxygenSaturation),
      'bloodGlucose': serializer.toJson<double?>(bloodGlucose),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VitalSign copyWith({
    int? id,
    int? patientId,
    DateTime? timestamp,
    double? temperature,
    int? heartRate,
    int? respiratoryRate,
    String? bloodPressure,
    int? oxygenSaturation,
    Value<double?> bloodGlucose = const Value.absent(),
    DateTime? createdAt,
  }) => VitalSign(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    timestamp: timestamp ?? this.timestamp,
    temperature: temperature ?? this.temperature,
    heartRate: heartRate ?? this.heartRate,
    respiratoryRate: respiratoryRate ?? this.respiratoryRate,
    bloodPressure: bloodPressure ?? this.bloodPressure,
    oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
    bloodGlucose: bloodGlucose.present ? bloodGlucose.value : this.bloodGlucose,
    createdAt: createdAt ?? this.createdAt,
  );
  VitalSign copyWithCompanion(VitalSignsCompanion data) {
    return VitalSign(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      temperature: data.temperature.present
          ? data.temperature.value
          : this.temperature,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      respiratoryRate: data.respiratoryRate.present
          ? data.respiratoryRate.value
          : this.respiratoryRate,
      bloodPressure: data.bloodPressure.present
          ? data.bloodPressure.value
          : this.bloodPressure,
      oxygenSaturation: data.oxygenSaturation.present
          ? data.oxygenSaturation.value
          : this.oxygenSaturation,
      bloodGlucose: data.bloodGlucose.present
          ? data.bloodGlucose.value
          : this.bloodGlucose,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VitalSign(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('timestamp: $timestamp, ')
          ..write('temperature: $temperature, ')
          ..write('heartRate: $heartRate, ')
          ..write('respiratoryRate: $respiratoryRate, ')
          ..write('bloodPressure: $bloodPressure, ')
          ..write('oxygenSaturation: $oxygenSaturation, ')
          ..write('bloodGlucose: $bloodGlucose, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    timestamp,
    temperature,
    heartRate,
    respiratoryRate,
    bloodPressure,
    oxygenSaturation,
    bloodGlucose,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VitalSign &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.timestamp == this.timestamp &&
          other.temperature == this.temperature &&
          other.heartRate == this.heartRate &&
          other.respiratoryRate == this.respiratoryRate &&
          other.bloodPressure == this.bloodPressure &&
          other.oxygenSaturation == this.oxygenSaturation &&
          other.bloodGlucose == this.bloodGlucose &&
          other.createdAt == this.createdAt);
}

class VitalSignsCompanion extends UpdateCompanion<VitalSign> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<DateTime> timestamp;
  final Value<double> temperature;
  final Value<int> heartRate;
  final Value<int> respiratoryRate;
  final Value<String> bloodPressure;
  final Value<int> oxygenSaturation;
  final Value<double?> bloodGlucose;
  final Value<DateTime> createdAt;
  const VitalSignsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.temperature = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.respiratoryRate = const Value.absent(),
    this.bloodPressure = const Value.absent(),
    this.oxygenSaturation = const Value.absent(),
    this.bloodGlucose = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VitalSignsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required DateTime timestamp,
    required double temperature,
    required int heartRate,
    required int respiratoryRate,
    required String bloodPressure,
    required int oxygenSaturation,
    this.bloodGlucose = const Value.absent(),
    required DateTime createdAt,
  }) : patientId = Value(patientId),
       timestamp = Value(timestamp),
       temperature = Value(temperature),
       heartRate = Value(heartRate),
       respiratoryRate = Value(respiratoryRate),
       bloodPressure = Value(bloodPressure),
       oxygenSaturation = Value(oxygenSaturation),
       createdAt = Value(createdAt);
  static Insertable<VitalSign> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<DateTime>? timestamp,
    Expression<double>? temperature,
    Expression<int>? heartRate,
    Expression<int>? respiratoryRate,
    Expression<String>? bloodPressure,
    Expression<int>? oxygenSaturation,
    Expression<double>? bloodGlucose,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (timestamp != null) 'timestamp': timestamp,
      if (temperature != null) 'temperature': temperature,
      if (heartRate != null) 'heart_rate': heartRate,
      if (respiratoryRate != null) 'respiratory_rate': respiratoryRate,
      if (bloodPressure != null) 'blood_pressure': bloodPressure,
      if (oxygenSaturation != null) 'oxygen_saturation': oxygenSaturation,
      if (bloodGlucose != null) 'blood_glucose': bloodGlucose,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VitalSignsCompanion copyWith({
    Value<int>? id,
    Value<int>? patientId,
    Value<DateTime>? timestamp,
    Value<double>? temperature,
    Value<int>? heartRate,
    Value<int>? respiratoryRate,
    Value<String>? bloodPressure,
    Value<int>? oxygenSaturation,
    Value<double?>? bloodGlucose,
    Value<DateTime>? createdAt,
  }) {
    return VitalSignsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      timestamp: timestamp ?? this.timestamp,
      temperature: temperature ?? this.temperature,
      heartRate: heartRate ?? this.heartRate,
      respiratoryRate: respiratoryRate ?? this.respiratoryRate,
      bloodPressure: bloodPressure ?? this.bloodPressure,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      bloodGlucose: bloodGlucose ?? this.bloodGlucose,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (respiratoryRate.present) {
      map['respiratory_rate'] = Variable<int>(respiratoryRate.value);
    }
    if (bloodPressure.present) {
      map['blood_pressure'] = Variable<String>(bloodPressure.value);
    }
    if (oxygenSaturation.present) {
      map['oxygen_saturation'] = Variable<int>(oxygenSaturation.value);
    }
    if (bloodGlucose.present) {
      map['blood_glucose'] = Variable<double>(bloodGlucose.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VitalSignsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('timestamp: $timestamp, ')
          ..write('temperature: $temperature, ')
          ..write('heartRate: $heartRate, ')
          ..write('respiratoryRate: $respiratoryRate, ')
          ..write('bloodPressure: $bloodPressure, ')
          ..write('oxygenSaturation: $oxygenSaturation, ')
          ..write('bloodGlucose: $bloodGlucose, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ConsultationsTable extends Consultations
    with TableInfo<$ConsultationsTable, Consultation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsultationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _patientIdMeta = const VerificationMeta(
    'patientId',
  );
  @override
  late final GeneratedColumn<int> patientId = GeneratedColumn<int>(
    'patient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES patients (id)',
    ),
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doctorIdMeta = const VerificationMeta(
    'doctorId',
  );
  @override
  late final GeneratedColumn<String> doctorId = GeneratedColumn<String>(
    'doctor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    patientId,
    scheduledAt,
    doctorId,
    doctorName,
    note,
    type,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consultations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Consultation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('patient_id')) {
      context.handle(
        _patientIdMeta,
        patientId.isAcceptableOrUnknown(data['patient_id']!, _patientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_patientIdMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('doctor_id')) {
      context.handle(
        _doctorIdMeta,
        doctorId.isAcceptableOrUnknown(data['doctor_id']!, _doctorIdMeta),
      );
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
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
  Consultation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Consultation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      patientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}patient_id'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      doctorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_id'],
      ),
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
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
  $ConsultationsTable createAlias(String alias) {
    return $ConsultationsTable(attachedDatabase, alias);
  }
}

class Consultation extends DataClass implements Insertable<Consultation> {
  final int id;
  final int patientId;
  final DateTime scheduledAt;
  final String? doctorId;
  final String? doctorName;
  final String note;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Consultation({
    required this.id,
    required this.patientId,
    required this.scheduledAt,
    this.doctorId,
    this.doctorName,
    required this.note,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['patient_id'] = Variable<int>(patientId);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    if (!nullToAbsent || doctorId != null) {
      map['doctor_id'] = Variable<String>(doctorId);
    }
    if (!nullToAbsent || doctorName != null) {
      map['doctor_name'] = Variable<String>(doctorName);
    }
    map['note'] = Variable<String>(note);
    map['type'] = Variable<String>(type);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConsultationsCompanion toCompanion(bool nullToAbsent) {
    return ConsultationsCompanion(
      id: Value(id),
      patientId: Value(patientId),
      scheduledAt: Value(scheduledAt),
      doctorId: doctorId == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorId),
      doctorName: doctorName == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorName),
      note: Value(note),
      type: Value(type),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Consultation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Consultation(
      id: serializer.fromJson<int>(json['id']),
      patientId: serializer.fromJson<int>(json['patientId']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      doctorId: serializer.fromJson<String?>(json['doctorId']),
      doctorName: serializer.fromJson<String?>(json['doctorName']),
      note: serializer.fromJson<String>(json['note']),
      type: serializer.fromJson<String>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'patientId': serializer.toJson<int>(patientId),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'doctorId': serializer.toJson<String?>(doctorId),
      'doctorName': serializer.toJson<String?>(doctorName),
      'note': serializer.toJson<String>(note),
      'type': serializer.toJson<String>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Consultation copyWith({
    int? id,
    int? patientId,
    DateTime? scheduledAt,
    Value<String?> doctorId = const Value.absent(),
    Value<String?> doctorName = const Value.absent(),
    String? note,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Consultation(
    id: id ?? this.id,
    patientId: patientId ?? this.patientId,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    doctorId: doctorId.present ? doctorId.value : this.doctorId,
    doctorName: doctorName.present ? doctorName.value : this.doctorName,
    note: note ?? this.note,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Consultation copyWithCompanion(ConsultationsCompanion data) {
    return Consultation(
      id: data.id.present ? data.id.value : this.id,
      patientId: data.patientId.present ? data.patientId.value : this.patientId,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      doctorId: data.doctorId.present ? data.doctorId.value : this.doctorId,
      doctorName: data.doctorName.present
          ? data.doctorName.value
          : this.doctorName,
      note: data.note.present ? data.note.value : this.note,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Consultation(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('note: $note, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    patientId,
    scheduledAt,
    doctorId,
    doctorName,
    note,
    type,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Consultation &&
          other.id == this.id &&
          other.patientId == this.patientId &&
          other.scheduledAt == this.scheduledAt &&
          other.doctorId == this.doctorId &&
          other.doctorName == this.doctorName &&
          other.note == this.note &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ConsultationsCompanion extends UpdateCompanion<Consultation> {
  final Value<int> id;
  final Value<int> patientId;
  final Value<DateTime> scheduledAt;
  final Value<String?> doctorId;
  final Value<String?> doctorName;
  final Value<String> note;
  final Value<String> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ConsultationsCompanion({
    this.id = const Value.absent(),
    this.patientId = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.note = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ConsultationsCompanion.insert({
    this.id = const Value.absent(),
    required int patientId,
    required DateTime scheduledAt,
    this.doctorId = const Value.absent(),
    this.doctorName = const Value.absent(),
    required String note,
    required String type,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : patientId = Value(patientId),
       scheduledAt = Value(scheduledAt),
       note = Value(note),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Consultation> custom({
    Expression<int>? id,
    Expression<int>? patientId,
    Expression<DateTime>? scheduledAt,
    Expression<String>? doctorId,
    Expression<String>? doctorName,
    Expression<String>? note,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (patientId != null) 'patient_id': patientId,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (doctorId != null) 'doctor_id': doctorId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (note != null) 'note': note,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ConsultationsCompanion copyWith({
    Value<int>? id,
    Value<int>? patientId,
    Value<DateTime>? scheduledAt,
    Value<String?>? doctorId,
    Value<String?>? doctorName,
    Value<String>? note,
    Value<String>? type,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ConsultationsCompanion(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      doctorId: doctorId ?? this.doctorId,
      doctorName: doctorName ?? this.doctorName,
      note: note ?? this.note,
      type: type ?? this.type,
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
    if (patientId.present) {
      map['patient_id'] = Variable<int>(patientId.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (doctorId.present) {
      map['doctor_id'] = Variable<String>(doctorId.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
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
    return (StringBuffer('ConsultationsCompanion(')
          ..write('id: $id, ')
          ..write('patientId: $patientId, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('doctorId: $doctorId, ')
          ..write('doctorName: $doctorName, ')
          ..write('note: $note, ')
          ..write('type: $type, ')
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
  late final $VitalSignsTable vitalSigns = $VitalSignsTable(this);
  late final $ConsultationsTable consultations = $ConsultationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    patients,
    vitalSigns,
    consultations,
  ];
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

final class $$PatientsTableReferences
    extends BaseReferences<_$AppDatabase, $PatientsTable, Patient> {
  $$PatientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VitalSignsTable, List<VitalSign>>
  _vitalSignsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vitalSigns,
    aliasName: $_aliasNameGenerator(db.patients.id, db.vitalSigns.patientId),
  );

  $$VitalSignsTableProcessedTableManager get vitalSignsRefs {
    final manager = $$VitalSignsTableTableManager(
      $_db,
      $_db.vitalSigns,
    ).filter((f) => f.patientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vitalSignsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ConsultationsTable, List<Consultation>>
  _consultationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.consultations,
    aliasName: $_aliasNameGenerator(db.patients.id, db.consultations.patientId),
  );

  $$ConsultationsTableProcessedTableManager get consultationsRefs {
    final manager = $$ConsultationsTableTableManager(
      $_db,
      $_db.consultations,
    ).filter((f) => f.patientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_consultationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  Expression<bool> vitalSignsRefs(
    Expression<bool> Function($$VitalSignsTableFilterComposer f) f,
  ) {
    final $$VitalSignsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vitalSigns,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VitalSignsTableFilterComposer(
            $db: $db,
            $table: $db.vitalSigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> consultationsRefs(
    Expression<bool> Function($$ConsultationsTableFilterComposer f) f,
  ) {
    final $$ConsultationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consultations,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsultationsTableFilterComposer(
            $db: $db,
            $table: $db.consultations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  Expression<T> vitalSignsRefs<T extends Object>(
    Expression<T> Function($$VitalSignsTableAnnotationComposer a) f,
  ) {
    final $$VitalSignsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vitalSigns,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VitalSignsTableAnnotationComposer(
            $db: $db,
            $table: $db.vitalSigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> consultationsRefs<T extends Object>(
    Expression<T> Function($$ConsultationsTableAnnotationComposer a) f,
  ) {
    final $$ConsultationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.consultations,
      getReferencedColumn: (t) => t.patientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsultationsTableAnnotationComposer(
            $db: $db,
            $table: $db.consultations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (Patient, $$PatientsTableReferences),
          Patient,
          PrefetchHooks Function({bool vitalSignsRefs, bool consultationsRefs})
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$PatientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({vitalSignsRefs = false, consultationsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (vitalSignsRefs) db.vitalSigns,
                    if (consultationsRefs) db.consultations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (vitalSignsRefs)
                        await $_getPrefetchedData<
                          Patient,
                          $PatientsTable,
                          VitalSign
                        >(
                          currentTable: table,
                          referencedTable: $$PatientsTableReferences
                              ._vitalSignsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientsTableReferences(
                                db,
                                table,
                                p0,
                              ).vitalSignsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (consultationsRefs)
                        await $_getPrefetchedData<
                          Patient,
                          $PatientsTable,
                          Consultation
                        >(
                          currentTable: table,
                          referencedTable: $$PatientsTableReferences
                              ._consultationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PatientsTableReferences(
                                db,
                                table,
                                p0,
                              ).consultationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.patientId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
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
      (Patient, $$PatientsTableReferences),
      Patient,
      PrefetchHooks Function({bool vitalSignsRefs, bool consultationsRefs})
    >;
typedef $$VitalSignsTableCreateCompanionBuilder =
    VitalSignsCompanion Function({
      Value<int> id,
      required int patientId,
      required DateTime timestamp,
      required double temperature,
      required int heartRate,
      required int respiratoryRate,
      required String bloodPressure,
      required int oxygenSaturation,
      Value<double?> bloodGlucose,
      required DateTime createdAt,
    });
typedef $$VitalSignsTableUpdateCompanionBuilder =
    VitalSignsCompanion Function({
      Value<int> id,
      Value<int> patientId,
      Value<DateTime> timestamp,
      Value<double> temperature,
      Value<int> heartRate,
      Value<int> respiratoryRate,
      Value<String> bloodPressure,
      Value<int> oxygenSaturation,
      Value<double?> bloodGlucose,
      Value<DateTime> createdAt,
    });

final class $$VitalSignsTableReferences
    extends BaseReferences<_$AppDatabase, $VitalSignsTable, VitalSign> {
  $$VitalSignsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
        $_aliasNameGenerator(db.vitalSigns.patientId, db.patients.id),
      );

  $$PatientsTableProcessedTableManager get patientId {
    final $_column = $_itemColumn<int>('patient_id')!;

    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VitalSignsTableFilterComposer
    extends Composer<_$AppDatabase, $VitalSignsTable> {
  $$VitalSignsTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get respiratoryRate => $composableBuilder(
    column: $table.respiratoryRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodPressure => $composableBuilder(
    column: $table.bloodPressure,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get oxygenSaturation => $composableBuilder(
    column: $table.oxygenSaturation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bloodGlucose => $composableBuilder(
    column: $table.bloodGlucose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VitalSignsTableOrderingComposer
    extends Composer<_$AppDatabase, $VitalSignsTable> {
  $$VitalSignsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get respiratoryRate => $composableBuilder(
    column: $table.respiratoryRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodPressure => $composableBuilder(
    column: $table.bloodPressure,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get oxygenSaturation => $composableBuilder(
    column: $table.oxygenSaturation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bloodGlucose => $composableBuilder(
    column: $table.bloodGlucose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableOrderingComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VitalSignsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VitalSignsTable> {
  $$VitalSignsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
    column: $table.temperature,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<int> get respiratoryRate => $composableBuilder(
    column: $table.respiratoryRate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bloodPressure => $composableBuilder(
    column: $table.bloodPressure,
    builder: (column) => column,
  );

  GeneratedColumn<int> get oxygenSaturation => $composableBuilder(
    column: $table.oxygenSaturation,
    builder: (column) => column,
  );

  GeneratedColumn<double> get bloodGlucose => $composableBuilder(
    column: $table.bloodGlucose,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VitalSignsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VitalSignsTable,
          VitalSign,
          $$VitalSignsTableFilterComposer,
          $$VitalSignsTableOrderingComposer,
          $$VitalSignsTableAnnotationComposer,
          $$VitalSignsTableCreateCompanionBuilder,
          $$VitalSignsTableUpdateCompanionBuilder,
          (VitalSign, $$VitalSignsTableReferences),
          VitalSign,
          PrefetchHooks Function({bool patientId})
        > {
  $$VitalSignsTableTableManager(_$AppDatabase db, $VitalSignsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VitalSignsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VitalSignsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VitalSignsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> patientId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> temperature = const Value.absent(),
                Value<int> heartRate = const Value.absent(),
                Value<int> respiratoryRate = const Value.absent(),
                Value<String> bloodPressure = const Value.absent(),
                Value<int> oxygenSaturation = const Value.absent(),
                Value<double?> bloodGlucose = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => VitalSignsCompanion(
                id: id,
                patientId: patientId,
                timestamp: timestamp,
                temperature: temperature,
                heartRate: heartRate,
                respiratoryRate: respiratoryRate,
                bloodPressure: bloodPressure,
                oxygenSaturation: oxygenSaturation,
                bloodGlucose: bloodGlucose,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int patientId,
                required DateTime timestamp,
                required double temperature,
                required int heartRate,
                required int respiratoryRate,
                required String bloodPressure,
                required int oxygenSaturation,
                Value<double?> bloodGlucose = const Value.absent(),
                required DateTime createdAt,
              }) => VitalSignsCompanion.insert(
                id: id,
                patientId: patientId,
                timestamp: timestamp,
                temperature: temperature,
                heartRate: heartRate,
                respiratoryRate: respiratoryRate,
                bloodPressure: bloodPressure,
                oxygenSaturation: oxygenSaturation,
                bloodGlucose: bloodGlucose,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VitalSignsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (patientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.patientId,
                                referencedTable: $$VitalSignsTableReferences
                                    ._patientIdTable(db),
                                referencedColumn: $$VitalSignsTableReferences
                                    ._patientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VitalSignsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VitalSignsTable,
      VitalSign,
      $$VitalSignsTableFilterComposer,
      $$VitalSignsTableOrderingComposer,
      $$VitalSignsTableAnnotationComposer,
      $$VitalSignsTableCreateCompanionBuilder,
      $$VitalSignsTableUpdateCompanionBuilder,
      (VitalSign, $$VitalSignsTableReferences),
      VitalSign,
      PrefetchHooks Function({bool patientId})
    >;
typedef $$ConsultationsTableCreateCompanionBuilder =
    ConsultationsCompanion Function({
      Value<int> id,
      required int patientId,
      required DateTime scheduledAt,
      Value<String?> doctorId,
      Value<String?> doctorName,
      required String note,
      required String type,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$ConsultationsTableUpdateCompanionBuilder =
    ConsultationsCompanion Function({
      Value<int> id,
      Value<int> patientId,
      Value<DateTime> scheduledAt,
      Value<String?> doctorId,
      Value<String?> doctorName,
      Value<String> note,
      Value<String> type,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$ConsultationsTableReferences
    extends BaseReferences<_$AppDatabase, $ConsultationsTable, Consultation> {
  $$ConsultationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PatientsTable _patientIdTable(_$AppDatabase db) =>
      db.patients.createAlias(
        $_aliasNameGenerator(db.consultations.patientId, db.patients.id),
      );

  $$PatientsTableProcessedTableManager get patientId {
    final $_column = $_itemColumn<int>('patient_id')!;

    final manager = $$PatientsTableTableManager(
      $_db,
      $_db.patients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_patientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ConsultationsTableFilterComposer
    extends Composer<_$AppDatabase, $ConsultationsTable> {
  $$ConsultationsTableFilterComposer({
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

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
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

  $$PatientsTableFilterComposer get patientId {
    final $$PatientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableFilterComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsultationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsultationsTable> {
  $$ConsultationsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorId => $composableBuilder(
    column: $table.doctorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
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

  $$PatientsTableOrderingComposer get patientId {
    final $$PatientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableOrderingComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsultationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsultationsTable> {
  $$ConsultationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get doctorId =>
      $composableBuilder(column: $table.doctorId, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$PatientsTableAnnotationComposer get patientId {
    final $$PatientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.patientId,
      referencedTable: $db.patients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PatientsTableAnnotationComposer(
            $db: $db,
            $table: $db.patients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ConsultationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsultationsTable,
          Consultation,
          $$ConsultationsTableFilterComposer,
          $$ConsultationsTableOrderingComposer,
          $$ConsultationsTableAnnotationComposer,
          $$ConsultationsTableCreateCompanionBuilder,
          $$ConsultationsTableUpdateCompanionBuilder,
          (Consultation, $$ConsultationsTableReferences),
          Consultation,
          PrefetchHooks Function({bool patientId})
        > {
  $$ConsultationsTableTableManager(_$AppDatabase db, $ConsultationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsultationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsultationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsultationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> patientId = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<String?> doctorId = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ConsultationsCompanion(
                id: id,
                patientId: patientId,
                scheduledAt: scheduledAt,
                doctorId: doctorId,
                doctorName: doctorName,
                note: note,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int patientId,
                required DateTime scheduledAt,
                Value<String?> doctorId = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                required String note,
                required String type,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => ConsultationsCompanion.insert(
                id: id,
                patientId: patientId,
                scheduledAt: scheduledAt,
                doctorId: doctorId,
                doctorName: doctorName,
                note: note,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ConsultationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({patientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (patientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.patientId,
                                referencedTable: $$ConsultationsTableReferences
                                    ._patientIdTable(db),
                                referencedColumn: $$ConsultationsTableReferences
                                    ._patientIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ConsultationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsultationsTable,
      Consultation,
      $$ConsultationsTableFilterComposer,
      $$ConsultationsTableOrderingComposer,
      $$ConsultationsTableAnnotationComposer,
      $$ConsultationsTableCreateCompanionBuilder,
      $$ConsultationsTableUpdateCompanionBuilder,
      (Consultation, $$ConsultationsTableReferences),
      Consultation,
      PrefetchHooks Function({bool patientId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PatientsTableTableManager get patients =>
      $$PatientsTableTableManager(_db, _db.patients);
  $$VitalSignsTableTableManager get vitalSigns =>
      $$VitalSignsTableTableManager(_db, _db.vitalSigns);
  $$ConsultationsTableTableManager get consultations =>
      $$ConsultationsTableTableManager(_db, _db.consultations);
}
