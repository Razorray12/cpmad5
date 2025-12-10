// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppState on _AppState, Store {
  Computed<int>? _$consultationsCountComputed;

  @override
  int get consultationsCount => (_$consultationsCountComputed ??= Computed<int>(
    () => super.consultationsCount,
    name: '_AppState.consultationsCount',
  )).value;
  Computed<Patient?>? _$lastAddedPatientComputed;

  @override
  Patient? get lastAddedPatient =>
      (_$lastAddedPatientComputed ??= Computed<Patient?>(
        () => super.lastAddedPatient,
        name: '_AppState.lastAddedPatient',
      )).value;
  Computed<Patient?>? _$admissionPatientComputed;

  @override
  Patient? get admissionPatient =>
      (_$admissionPatientComputed ??= Computed<Patient?>(
        () => super.admissionPatient,
        name: '_AppState.admissionPatient',
      )).value;

  late final _$patientsAtom = Atom(
    name: '_AppState.patients',
    context: context,
  );

  @override
  ObservableList<Patient> get patients {
    _$patientsAtom.reportRead();
    return super.patients;
  }

  @override
  set patients(ObservableList<Patient> value) {
    _$patientsAtom.reportWrite(value, super.patients, () {
      super.patients = value;
    });
  }

  late final _$vitalsByPatientAtom = Atom(
    name: '_AppState.vitalsByPatient',
    context: context,
  );

  @override
  ObservableMap<int, ObservableList<VitalSign>> get vitalsByPatient {
    _$vitalsByPatientAtom.reportRead();
    return super.vitalsByPatient;
  }

  @override
  set vitalsByPatient(ObservableMap<int, ObservableList<VitalSign>> value) {
    _$vitalsByPatientAtom.reportWrite(value, super.vitalsByPatient, () {
      super.vitalsByPatient = value;
    });
  }

  late final _$consultationsAtom = Atom(
    name: '_AppState.consultations',
    context: context,
  );

  @override
  ObservableList<Consultation> get consultations {
    _$consultationsAtom.reportRead();
    return super.consultations;
  }

  @override
  set consultations(ObservableList<Consultation> value) {
    _$consultationsAtom.reportWrite(value, super.consultations, () {
      super.consultations = value;
    });
  }

  late final _$lastAddedPatientIdAtom = Atom(
    name: '_AppState.lastAddedPatientId',
    context: context,
  );

  @override
  int? get lastAddedPatientId {
    _$lastAddedPatientIdAtom.reportRead();
    return super.lastAddedPatientId;
  }

  @override
  set lastAddedPatientId(int? value) {
    _$lastAddedPatientIdAtom.reportWrite(value, super.lastAddedPatientId, () {
      super.lastAddedPatientId = value;
    });
  }

  late final _$admissionPatientIdAtom = Atom(
    name: '_AppState.admissionPatientId',
    context: context,
  );

  @override
  int? get admissionPatientId {
    _$admissionPatientIdAtom.reportRead();
    return super.admissionPatientId;
  }

  @override
  set admissionPatientId(int? value) {
    _$admissionPatientIdAtom.reportWrite(value, super.admissionPatientId, () {
      super.admissionPatientId = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_AppState.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorAtom = Atom(name: '_AppState.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$loadDataAsyncAction = AsyncAction(
    '_AppState.loadData',
    context: context,
  );

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  late final _$addPatientAsyncAction = AsyncAction(
    '_AppState.addPatient',
    context: context,
  );

  @override
  Future<Patient> addPatient({
    required String firstName,
    required String lastName,
    String? middleName,
    String? birthDate,
    String? phoneNumber,
    required String diagnosis,
    String? room,
    String? sex,
    String? admissionDate,
    String? medications,
    String? allergies,
    String? mainDoctor,
    String? mainDoctorID,
    required PatientStatus status,
    String? imageUrl,
  }) {
    return _$addPatientAsyncAction.run(
      () => super.addPatient(
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
        mainDoctorID: mainDoctorID,
        status: status,
        imageUrl: imageUrl,
      ),
    );
  }

  late final _$removePatientAsyncAction = AsyncAction(
    '_AppState.removePatient',
    context: context,
  );

  @override
  Future<void> removePatient(int id) {
    return _$removePatientAsyncAction.run(() => super.removePatient(id));
  }

  late final _$updatePatientAsyncAction = AsyncAction(
    '_AppState.updatePatient',
    context: context,
  );

  @override
  Future<void> updatePatient(Patient updatedPatient) {
    return _$updatePatientAsyncAction.run(
      () => super.updatePatient(updatedPatient),
    );
  }

  late final _$addVitalAsyncAction = AsyncAction(
    '_AppState.addVital',
    context: context,
  );

  @override
  Future<void> addVital(int patientId, VitalSign vital) {
    return _$addVitalAsyncAction.run(() => super.addVital(patientId, vital));
  }

  late final _$removeVitalAsyncAction = AsyncAction(
    '_AppState.removeVital',
    context: context,
  );

  @override
  Future<void> removeVital(int patientId, VitalSign vital) {
    return _$removeVitalAsyncAction.run(
      () => super.removeVital(patientId, vital),
    );
  }

  late final _$addConsultationAsyncAction = AsyncAction(
    '_AppState.addConsultation',
    context: context,
  );

  @override
  Future<void> addConsultation(Consultation c) {
    return _$addConsultationAsyncAction.run(() => super.addConsultation(c));
  }

  late final _$removeConsultationAsyncAction = AsyncAction(
    '_AppState.removeConsultation',
    context: context,
  );

  @override
  Future<void> removeConsultation(Consultation consultation) {
    return _$removeConsultationAsyncAction.run(
      () => super.removeConsultation(consultation),
    );
  }

  late final _$updateConsultationAsyncAction = AsyncAction(
    '_AppState.updateConsultation',
    context: context,
  );

  @override
  Future<void> updateConsultation(Consultation updatedConsultation) {
    return _$updateConsultationAsyncAction.run(
      () => super.updateConsultation(updatedConsultation),
    );
  }

  late final _$_AppStateActionController = ActionController(
    name: '_AppState',
    context: context,
  );

  @override
  void setAdmissionPatientId(int id) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.setAdmissionPatientId',
    );
    try {
      return super.setAdmissionPatientId(id);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAdmission() {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.clearAdmission',
    );
    try {
      return super.clearAdmission();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAllData() {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.clearAllData',
    );
    try {
      return super.clearAllData();
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
patients: ${patients},
vitalsByPatient: ${vitalsByPatient},
consultations: ${consultations},
lastAddedPatientId: ${lastAddedPatientId},
admissionPatientId: ${admissionPatientId},
isLoading: ${isLoading},
error: ${error},
consultationsCount: ${consultationsCount},
lastAddedPatient: ${lastAddedPatient},
admissionPatient: ${admissionPatient}
    ''';
  }
}
