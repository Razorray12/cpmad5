import 'package:flutter/material.dart';
import '../../../../shared/constants/app_constants.dart';

/// Форма для добавления/редактирования пациента
class PatientForm extends StatefulWidget {
  final Function({
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
  }) onSubmit;

  const PatientForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<PatientForm> createState() => PatientFormState();
}

class PatientFormState extends State<PatientForm> {
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

  String _status = AppConstants.patientStatusStable;
  String? _sex;

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
      widget.onSubmit(
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
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Фамилия *'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Фамилия обязательна';
                }
                if (value.trim().length < AppConstants.minNameLength) {
                  return 'Фамилия должна содержать минимум ${AppConstants.minNameLength} символа';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'Имя *'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Имя обязательно';
                }
                if (value.trim().length < AppConstants.minNameLength) {
                  return 'Имя должно содержать минимум ${AppConstants.minNameLength} символа';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _middleNameController,
              decoration: const InputDecoration(labelText: 'Отчество'),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _birthDateController,
              decoration: const InputDecoration(labelText: 'Дата рождения'),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _diagnosisController,
              decoration: const InputDecoration(labelText: 'Диагноз *'),
              maxLines: 2,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Диагноз обязателен';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _roomController,
              decoration: const InputDecoration(labelText: 'Палата'),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            DropdownButtonFormField<String>(
              value: _sex,
              items: const [
                DropdownMenuItem(
                  value: AppConstants.patientSexMale,
                  child: Text(AppConstants.patientSexMale),
                ),
                DropdownMenuItem(
                  value: AppConstants.patientSexFemale,
                  child: Text(AppConstants.patientSexFemale),
                ),
              ],
              onChanged: (value) => setState(() => _sex = value),
              decoration: const InputDecoration(labelText: 'Пол'),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _admissionController,
              decoration: const InputDecoration(labelText: 'Дата поступления'),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _medicationsController,
              decoration: const InputDecoration(labelText: 'Назначения'),
              maxLines: 2,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _allergiesController,
              decoration: const InputDecoration(labelText: 'Аллергии'),
              maxLines: 2,
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _mainDoctorController,
              decoration: const InputDecoration(labelText: 'Лечащий врач'),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _mainDoctorIdController,
              decoration: const InputDecoration(labelText: 'ID врача'),
            ),
            const SizedBox(height: AppConstants.smallPadding),
            DropdownButtonFormField<String>(
              value: _status,
              decoration: const InputDecoration(labelText: 'Статус *'),
              items: const [
                DropdownMenuItem(
                  value: AppConstants.patientStatusStable,
                  child: Text(AppConstants.patientStatusStable),
                ),
                DropdownMenuItem(
                  value: AppConstants.patientStatusUnderObservation,
                  child: Text(AppConstants.patientStatusUnderObservation),
                ),
                DropdownMenuItem(
                  value: AppConstants.patientStatusCritical,
                  child: Text(AppConstants.patientStatusCritical),
                ),
              ],
              onChanged: (value) => setState(() => _status = value ?? _status),
            ),
          ],
        ),
      ),
    );
  }
}
