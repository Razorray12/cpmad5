import 'package:flutter/material.dart';
import '../../../../shared/constants/app_constants.dart';

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
            TextFormField(
              controller: _temperatureController,
              decoration: const InputDecoration(labelText: 'Температура *'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Температура обязательна';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _heartRateController,
              decoration: const InputDecoration(labelText: 'Пульс *'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Пульс обязателен';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _respiratoryRateController,
              decoration: const InputDecoration(labelText: 'Дыхание *'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Дыхание обязательно';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _bloodPressureController,
              decoration: const InputDecoration(labelText: 'АД *'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Артериальное давление обязательно';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _oxygenSaturationController,
              decoration: const InputDecoration(labelText: 'SpO₂ *'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'SpO₂ обязательно';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.smallPadding),
            TextFormField(
              controller: _bloodGlucoseController,
              decoration: const InputDecoration(labelText: 'Глюкоза крови'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
