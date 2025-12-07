part of 'app_state.dart';

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
  Patient addPatient({
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
    required String status,
    String? imageUrl,
  }) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.addPatient',
    );
    try {
      return super.addPatient(
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
      );
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePatient(int id) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.removePatient',
    );
    try {
      return super.removePatient(id);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addVital(int patientId, VitalSign vital) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.addVital',
    );
    try {
      return super.addVital(patientId, vital);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeVital(int patientId, VitalSign vital) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.removeVital',
    );
    try {
      return super.removeVital(patientId, vital);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addConsultation(Consultation c) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.addConsultation',
    );
    try {
      return super.addConsultation(c);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeConsultation(Consultation consultation) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.removeConsultation',
    );
    try {
      return super.removeConsultation(consultation);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updatePatient(Patient updatedPatient) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.updatePatient',
    );
    try {
      return super.updatePatient(updatedPatient);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateConsultation(Consultation updatedConsultation) {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.updateConsultation',
    );
    try {
      return super.updateConsultation(updatedConsultation);
    } finally {
      _$_AppStateActionController.endAction(_$actionInfo);
    }
  }

  @override
  void initializeSampleData() {
    final _$actionInfo = _$_AppStateActionController.startAction(
      name: '_AppState.initializeSampleData',
    );
    try {
      return super.initializeSampleData();
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
consultationsCount: ${consultationsCount},
lastAddedPatient: ${lastAddedPatient},
admissionPatient: ${admissionPatient}
    ''';
  }
}
