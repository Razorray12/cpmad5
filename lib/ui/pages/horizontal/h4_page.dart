import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/horizontal_step_page.dart';
import '../../../presentation/state/app_scope.dart';
import '../../../core/models/consultation.dart';
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
      id: 0,
      patientId: patientId,
      dateTime: DateTime.now(),
      note: '',
    );

    if (!hasNewPatient) {
      return HorizontalStepPage(
        title: 'Госпитализация: Первичная консультация',
        nextRoute: AppRoutes.h5,
        nextLabel: 'К итогу госпитализации',
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: EmptyState(
            icon: Icons.info_outline,
            message:
                'Нельзя оформить первичную консультацию: новый пациент не зарегистрирован.',
          ),
        ),
      );
    }

    if (!hasVitals) {
      return HorizontalStepPage(
        title: 'Госпитализация: Первичная консультация',
        nextRoute: AppRoutes.h5,
        nextLabel: 'К итогу госпитализации',
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: EmptyState(
            icon: Icons.warning_amber,
            message:
                'Нельзя оформить первичную консультацию: не внесены первичные показатели.',
          ),
        ),
      );
    }

    return HorizontalStepPage(
      title: 'Госпитализация: Первичная консультация',
      nextRoute: AppRoutes.h5,
      nextLabel: 'К итогу госпитализации',
      onNext: () {
        _formKey.currentState?.submit();
        context.go(AppRoutes.h5);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ConsultationEditForm(
          key: _formKey,
          consultation: draft,
          onSubmit: (updated) {
            app.addConsultation(updated);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Консультация сохранена')),
            );
          },
        ),
      ),
    );
  }
}
