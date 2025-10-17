import 'package:flutter/material.dart';
import '../models/consultation.dart';
import '../../../../shared/state/app_scope.dart';
import '../../../../shared/widgets/date_format.dart';

/// Форма для редактирования консультации
class ConsultationEditForm extends StatefulWidget {
  final Consultation consultation;
  final Function(Consultation updatedConsultation) onSubmit;

  const ConsultationEditForm({
    super.key,
    required this.consultation,
    required this.onSubmit,
  });

  @override
  State<ConsultationEditForm> createState() => ConsultationEditFormState();
}

class ConsultationEditFormState extends State<ConsultationEditForm> {
  final _formKey = GlobalKey<FormState>();
  final _doctorController = TextEditingController();
  final _noteController = TextEditingController();
  
  int _selectedPatientId = 0;
  DateTime _selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    final c = widget.consultation;
    _selectedPatientId = c.patientId;
    _selectedDateTime = c.dateTime;
    _doctorController.text = c.doctorName ?? '';
    _noteController.text = c.note;
  }

  @override
  void dispose() {
    _doctorController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedConsultation = Consultation(
        patientId: _selectedPatientId,
        dateTime: _selectedDateTime,
        doctorName: _doctorController.text.trim().isEmpty ? null : _doctorController.text.trim(),
        note: _noteController.text.trim(),
      );
      widget.onSubmit(updatedConsultation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final patients = state.patients;

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<int>(
              value: _selectedPatientId,
              items: patients
                  .map((p) => DropdownMenuItem(value: p.id, child: Text(p.fullName)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedPatientId = value ?? _selectedPatientId),
              decoration: const InputDecoration(labelText: 'Пациент *'),
              validator: (value) => value == null ? 'Выберите пациента' : null,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _doctorController,
              decoration: const InputDecoration(labelText: 'Врач (опц.)'),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _noteController,
              decoration: const InputDecoration(labelText: 'Описание *'),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Описание обязательно';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: Text('Дата: ${formatDateTimeDDMMYYYYHHMM(_selectedDateTime)}')),
                TextButton(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _selectedDateTime,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      final time = await showTimePicker(
                        context: context, 
                        initialTime: TimeOfDay.fromDateTime(_selectedDateTime)
                      );
                      setState(() {
                        _selectedDateTime = DateTime(
                          picked.year,
                          picked.month,
                          picked.day,
                          time?.hour ?? _selectedDateTime.hour,
                          time?.minute ?? _selectedDateTime.minute,
                        );
                      });
                    }
                  },
                  child: const Text('Выбрать'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
