import 'package:flutter/material.dart';

/// Информационная панель с светлой подложкой и скруглением
class InfoPanel extends StatelessWidget {
  final Widget child;

  const InfoPanel({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: child,
    );
  }
}


