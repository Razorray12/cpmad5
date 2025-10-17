import 'package:flutter/material.dart';

/// Универсальный заголовок секции с опциональной кнопкой действия
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData? actionIcon;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionIcon,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          if (onAction != null && actionIcon != null && actionLabel != null)
            ElevatedButton.icon(
              onPressed: onAction,
              icon: Icon(actionIcon),
              label: Text(actionLabel!),
            ),
        ],
      ),
    );
  }
}


