import 'package:flutter/material.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/widgets/form_fields.dart';
import '../models/patient.dart';

/// Форма для редактирования данных пациента
class PatientEditForm extends StatefulWidget {
  final Patient patient;
  final Function(Patient updatedPatient) onSubmit;

  const PatientEditForm({
    super.key,
    required this.patient,
    required this.onSubmit,
  });

  @override
  State<PatientEditForm> createState() => PatientEditFormState();
}

class PatientEditFormState extends State<PatientEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _phoneController = TextEditingController();
  final _diagnosisController = TextEditingController();
  final _roomController = TextEditingController();
  final _admissionController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _mainDoctorController = TextEditingController();
  final _mainDoctorIdController = TextEditingController();

  String _status = '';
  String? _sex;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    final p = widget.patient;
    _lastNameController.text = p.lastName;
    _firstNameController.text = p.firstName;
    _middleNameController.text = p.middleName ?? '';
    _birthDateController.text = p.birthDate ?? '';
    _phoneController.text = p.phoneNumber ?? '';
    _diagnosisController.text = p.diagnosis;
    _roomController.text = p.room ?? '';
    _admissionController.text = p.admissionDate ?? '';
    _medicationsController.text = p.medications ?? '';
    _allergiesController.text = p.allergies ?? '';
    _mainDoctorController.text = p.mainDoctor ?? '';
    _mainDoctorIdController.text = p.mainDoctorID ?? '';
    _status = p.status;
    _sex = p.sex;
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _middleNameController.dispose();
    _birthDateController.dispose();
    _phoneController.dispose();
    _diagnosisController.dispose();
    _roomController.dispose();
    _admissionController.dispose();
    _medicationsController.dispose();
    _allergiesController.dispose();
    _mainDoctorController.dispose();
    _mainDoctorIdController.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedPatient = Patient(
        id: widget.patient.id,
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        middleName: _middleNameController.text.trim().isEmpty ? null : _middleNameController.text.trim(),
        birthDate: _birthDateController.text.trim().isEmpty ? null : _birthDateController.text.trim(),
        phoneNumber: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        diagnosis: _diagnosisController.text.trim(),
        room: _roomController.text.trim().isEmpty ? null : _roomController.text.trim(),
        sex: _sex,
        admissionDate: _admissionController.text.trim().isEmpty ? null : _admissionController.text.trim(),
        medications: _medicationsController.text.trim().isEmpty ? null : _medicationsController.text.trim(),
        allergies: _allergiesController.text.trim().isEmpty ? null : _allergiesController.text.trim(),
        mainDoctor: _mainDoctorController.text.trim().isEmpty ? null : _mainDoctorController.text.trim(),
        mainDoctorID: _mainDoctorIdController.text.trim().isEmpty ? null : _mainDoctorIdController.text.trim(),
        status: _status,
      );
      widget.onSubmit(updatedPatient);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(controller: _lastNameController, label: 'Фамилия', requiredField: true),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _firstNameController, label: 'Имя', requiredField: true),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _middleNameController, label: 'Отчество'),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _birthDateController, label: 'Дата рождения'),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _phoneController, label: 'Телефон', keyboardType: TextInputType.phone),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _diagnosisController, label: 'Диагноз', requiredField: true, maxLines: 2),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _roomController, label: 'Палата'),
            const SizedBox(height: AppConstants.smallPadding),
            AppDropdown<String>(
              label: 'Пол',
              value: _sex,
              items: const [AppConstants.patientSexMale, AppConstants.patientSexFemale],
              onChanged: (value) => setState(() => _sex = value),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _admissionController, label: 'Дата поступления'),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _medicationsController, label: 'Назначения', maxLines: 2),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _allergiesController, label: 'Аллергии', maxLines: 2),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _mainDoctorController, label: 'Лечащий врач'),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _mainDoctorIdController, label: 'ID врача'),
            const SizedBox(height: AppConstants.smallPadding),
            AppDropdown<String>(
              label: 'Статус',
              value: _status,
              requiredField: true,
              items: const [
                AppConstants.patientStatusStable,
                AppConstants.patientStatusUnderObservation,
                AppConstants.patientStatusCritical,
              ],
              onChanged: (value) => setState(() => _status = value ?? _status),
            ),
          ],
        ),
      ),
    );
  }
}
