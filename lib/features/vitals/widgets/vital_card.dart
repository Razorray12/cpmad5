import 'package:flutter/material.dart';
import '../models/vital_sign.dart';
import '../../../../shared/widgets/common_widgets.dart';

/// Карточка жизненных показателей
class VitalCard extends StatelessWidget {
  final VitalSign vital;

  const VitalCard({
    super.key,
    required this.vital,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _formatDate(vital.timestamp),
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                CommonWidgets.dataChip(
                  label: 'Температура',
                  value: vital.temperature,
                ),
                CommonWidgets.dataChip(
                  label: 'Пульс',
                  value: vital.heartRate,
                ),
                CommonWidgets.dataChip(
                  label: 'Дыхание',
                  value: vital.respiratoryRate,
                ),
                CommonWidgets.dataChip(
                  label: 'АД',
                  value: vital.bloodPressure,
                ),
                CommonWidgets.dataChip(
                  label: 'SpO₂',
                  value: vital.oxygenSaturation,
                ),
                if (vital.bloodGlucose != null)
                  CommonWidgets.dataChip(
                    label: 'Глюкоза',
                    value: vital.bloodGlucose!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime dt) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(dt.day)}.${two(dt.month)}.${dt.year} ${two(dt.hour)}:${two(dt.minute)}';
  }
}
