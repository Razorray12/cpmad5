import 'package:flutter/material.dart';
import '../models/vital_sign.dart';
import '../../../../shared/widgets/entity_card.dart';
import '../../../../shared/widgets/labeled_value_chip.dart';
import '../../../../shared/widgets/date_format.dart';

/// Карточка жизненных показателей
class VitalCard extends StatelessWidget {
  final VitalSign vital;

  const VitalCard({
    super.key,
    required this.vital,
  });

  @override
  Widget build(BuildContext context) {
    return EntityCard(
      title: formatDateTimeDDMMYYYYHHMM(vital.timestamp),
      subtitleWidgets: [
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            LabeledValueChip(label: 'Температура', value: vital.temperature),
            LabeledValueChip(label: 'Пульс', value: vital.heartRate),
            LabeledValueChip(label: 'Дыхание', value: vital.respiratoryRate),
            LabeledValueChip(label: 'АД', value: vital.bloodPressure),
            LabeledValueChip(label: 'SpO₂', value: vital.oxygenSaturation),
            if (vital.bloodGlucose != null)
              LabeledValueChip(label: 'Глюкоза', value: vital.bloodGlucose!),
          ],
        ),
      ],
    );
  }

  String _formatDate(DateTime dt) => formatDateTimeDDMMYYYYHHMM(dt);
}
