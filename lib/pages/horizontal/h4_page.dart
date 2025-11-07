import 'package:flutter/material.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/horizontal_step_page.dart';
import '../../shared/state/app_scope.dart';
import '../../features/consultations/models/consultation.dart';
import '../../features/consultations/widgets/consultation_edit_form.dart';
import '../../shared/widgets/empty_state.dart';

class H4Page extends StatefulWidget {
  const H4Page({super.key});

  @override
  State<H4Page> createState() => _H4PageState();
}

class _H4PageState extends State<H4Page> {
  final _formKey = GlobalKey<ConsultationEditFormState>();

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    final patientId = app.admissionPatientId ?? 0;
    final hasNewPatient = patientId != 0;
    final hasVitals = hasNewPatient && app.vitalsFor(patientId).isNotEmpty;

    final draft = Consultation(
      patientId: patientId,
      dateTime: DateTime.now(),
      note: '',
    );

    if (!hasNewPatient) {
      return HorizontalStepPage(
        title: 'Госпитализация: Первичная консультация',
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: EmptyState(icon: Icons.info_outline, message: 'Нельзя оформить первичную консультацию: новый пациент не зарегистрирован.'),
        ),
        nextRoute: AppRoutes.h5,
        nextLabel: 'К итогу госпитализации',
      );
    }

    if (!hasVitals) {
      return HorizontalStepPage(
        title: 'Госпитализация: Первичная консультация',
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: EmptyState(icon: Icons.warning_amber, message: 'Нельзя оформить первичную консультацию: не внесены первичные показатели.'),
        ),
        nextRoute: AppRoutes.h5,
        nextLabel: 'К итогу госпитализации',
      );
    }

    return HorizontalStepPage(
      title: 'Госпитализация: Первичная консультация',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConsultationEditForm(
          key: _formKey,
          consultation: draft,
          onSubmit: (updated) {
            app.addConsultation(updated);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Консультация сохранена')));
          },
        ),
      ),
      nextRoute: AppRoutes.h5,
      nextLabel: 'К итогу госпитализации',
      onNext: () {
        _formKey.currentState?.submit();
        Navigator.pushReplacementNamed(context, AppRoutes.h5);
      },
    );
  }
}


