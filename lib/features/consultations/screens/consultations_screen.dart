import 'package:flutter/material.dart';
import '../../../shared/state/app_scope.dart';
import '../models/consultation.dart';
import '../widgets/consultation_tile.dart';
import '../widgets/consultation_edit_form.dart';
import '../../../shared/widgets/dialog_form_scaffold.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  int? _selectedPatientId;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final consultations = _selectedPatientId == null 
        ? state.consultations 
        : state.consultationsForPatient(_selectedPatientId!);
    final patients = state.patients;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Консультации', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                onPressed: patients.isEmpty ? null : () => _showAddConsultationDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('Добавить'),
              )
            ],
          ),
        ),
        if (patients.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<int>(
              isExpanded: true,
              value: _selectedPatientId,
              hint: const Text('Все пациенты'),
              items: [
                const DropdownMenuItem<int>(value: null, child: Text('Все пациенты')),
                ...patients.map((p) => DropdownMenuItem<int>(value: p.id, child: Text(p.fullName))),
              ],
              onChanged: (value) => setState(() => _selectedPatientId = value),
            ),
          ),
          const SizedBox(height: 8),
        ],
        Expanded(
          child: consultations.isEmpty
              ? const Center(
                  child: Text('Консультации не найдены', style: TextStyle(fontSize: 16)),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: consultations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, index) => ConsultationTile(
                    consultation: consultations[index],
                    onDelete: () => AppScope.of(context).removeConsultation(consultations[index]),
                    onEdit: () => _showEditConsultationDialog(context, consultations[index]),
                  ),
                ),
        )
      ],
    );
  }

  void _showAddConsultationDialog(BuildContext context) {
    final state = AppScope.of(context);
    final patients = state.patients;
    int selectedId = patients.first.id;
    final doctorCtrl = TextEditingController();
    final noteCtrl = TextEditingController();
    DateTime when = DateTime.now();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Новая консультация'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<int>(
                initialValue: selectedId,
                items: patients
                    .map((p) => DropdownMenuItem(value: p.id, child: Text(p.fullName)))
                    .toList(),
                onChanged: (v) => selectedId = v ?? selectedId,
                decoration: const InputDecoration(labelText: 'Пациент'),
              ),
              const SizedBox(height: 8),
              TextField(controller: doctorCtrl, decoration: const InputDecoration(labelText: 'Врач (опц.)')),
              const SizedBox(height: 8),
              TextField(controller: noteCtrl, decoration: const InputDecoration(labelText: 'Описание')),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: Text('Дата: ${_fmtDate(when)}')),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: ctx,
                        initialDate: when,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        final time = await showTimePicker(context: ctx, initialTime: TimeOfDay.fromDateTime(when));
                        setState(() {
                          when = DateTime(
                            picked.year,
                            picked.month,
                            picked.day,
                            time?.hour ?? when.hour,
                            time?.minute ?? when.minute,
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
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              if (noteCtrl.text.trim().isEmpty) return;
              state.addConsultation(Consultation(
                patientId: selectedId,
                dateTime: when,
                doctorName: doctorCtrl.text.trim().isEmpty ? null : doctorCtrl.text.trim(),
                note: noteCtrl.text.trim(),
              ));
              Navigator.pop(ctx);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _showEditConsultationDialog(BuildContext context, Consultation consultation) {
    final formKey = GlobalKey<ConsultationEditFormState>();

    showDialog(
      context: context,
      builder: (ctx) => DialogFormScaffold<ConsultationEditFormState>(
        title: 'Редактировать консультацию',
        formKey: formKey,
        submitLabel: 'Сохранить',
        onSubmit: () => formKey.currentState?.submit(),
        child: ConsultationEditForm(
          key: formKey,
          consultation: consultation,
          onSubmit: (updatedConsultation) {
            AppScope.of(context).updateConsultation(updatedConsultation);
            Navigator.pop(ctx);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Консультация обновлена')),
            );
          },
        ),
      ),
    );
  }

  String _fmtDate(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}.${two(dt.month)}.${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }
}

