import 'package:flutter/material.dart';
import '../../../../shared/constants/app_constants.dart';
import '../../../../shared/widgets/form_fields.dart';

/// Форма для добавления жизненных показателей
class VitalForm extends StatefulWidget {
  final Function({
    required String temperature,
    required String heartRate,
    required String respiratoryRate,
    required String bloodPressure,
    required String oxygenSaturation,
    String? bloodGlucose,
  }) onSubmit;

  const VitalForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<VitalForm> createState() => VitalFormState();
}

class VitalFormState extends State<VitalForm> {
  final _formKey = GlobalKey<FormState>();
  final _temperatureController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _respiratoryRateController = TextEditingController();
  final _bloodPressureController = TextEditingController();
  final _oxygenSaturationController = TextEditingController();
  final _bloodGlucoseController = TextEditingController();

  @override
  void dispose() {
    _temperatureController.dispose();
    _heartRateController.dispose();
    _respiratoryRateController.dispose();
    _bloodPressureController.dispose();
    _oxygenSaturationController.dispose();
    _bloodGlucoseController.dispose();
    super.dispose();
  }

  void submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        temperature: _temperatureController.text.trim(),
        heartRate: _heartRateController.text.trim(),
        respiratoryRate: _respiratoryRateController.text.trim(),
        bloodPressure: _bloodPressureController.text.trim(),
        oxygenSaturation: _oxygenSaturationController.text.trim(),
        bloodGlucose: _bloodGlucoseController.text.trim().isEmpty ? null : _bloodGlucoseController.text.trim(),
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
            AppTextField(controller: _temperatureController, label: 'Температура', requiredField: true, keyboardType: TextInputType.number),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _heartRateController, label: 'Пульс', requiredField: true, keyboardType: TextInputType.number),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _respiratoryRateController, label: 'Дыхание', requiredField: true, keyboardType: TextInputType.number),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _bloodPressureController, label: 'АД', requiredField: true),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _oxygenSaturationController, label: 'SpO₂', requiredField: true, keyboardType: TextInputType.number),
            const SizedBox(height: AppConstants.smallPadding),
            AppTextField(controller: _bloodGlucoseController, label: 'Глюкоза крови', keyboardType: TextInputType.number),
          ],
        ),
      ),
    );
  }
}
