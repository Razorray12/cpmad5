import 'package:flutter/material.dart';

/// Базовый каркас карточки сущности
class EntityCard extends StatelessWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? subtitleWidgets;
  final Widget? trailing;
  final VoidCallback? onTap;

  const EntityCard({
    super.key,
    this.leading,
    required this.title,
    this.subtitleWidgets,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: leading,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitleWidgets == null
            ? null
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: subtitleWidgets!,
              ),
        trailing: trailing,
        onTap: onTap,
      ),
    );
  }
}


