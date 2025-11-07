import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/navigation/app_routes.dart';
import '../../shared/widgets/horizontal_step_page.dart';
import '../../shared/state/app_scope.dart';
import '../../features/patients/widgets/patient_form.dart';

class H2Page extends StatefulWidget {
  const H2Page({super.key});

  @override
  State<H2Page> createState() => _H2PageState();
}

class _H2PageState extends State<H2Page> {
  final _formKey = GlobalKey<PatientFormState>();

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);

    return HorizontalStepPage(
      title: 'Госпитализация: Регистрация пациента',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PatientForm(
          key: _formKey,
          onSubmit: ({
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
            final created = app.addPatient(
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
            app.setAdmissionPatientId(created.id);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Пациент добавлен')));
          },
        ),
      ),
      nextRoute: AppRoutes.h3,
      nextLabel: 'К первичным показателям',
      onNext: () {
        _formKey.currentState?.submit();
        context.go(AppRoutes.h3);
      },
    );
  }
}


