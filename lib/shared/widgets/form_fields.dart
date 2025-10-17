import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool requiredField;
  final TextInputType? keyboardType;
  final int maxLines;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.requiredField = false,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: requiredField ? '$label *' : label),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: !requiredField
          ? null
          : (value) => (value == null || value.trim().isEmpty) ? '$label обязательно' : null,
    );
  }
}

class AppDropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final bool requiredField;

  const AppDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.requiredField = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(labelText: requiredField ? '$label *' : label),
      items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
      onChanged: onChanged,
      validator: !requiredField ? null : (v) => v == null ? 'Выберите $label' : null,
    );
  }
}


