import 'package:flutter/material.dart';

/// Чип с меткой и значением: "Label: Value"
class LabeledValueChip extends StatelessWidget {
  final String label;
  final String value;
  final Color? backgroundColor;
  final Color? textColor;

  const LabeledValueChip({
    super.key,
    required this.label,
    required this.value,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(color: textColor),
    );
  }
}


