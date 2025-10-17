import 'package:flutter/material.dart';

/// Аватар с инициалом и цветом по статусу
class StatusAvatar extends StatelessWidget {
  final String initial;
  final String status;

  const StatusAvatar({
    super.key,
    required this.initial,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: colorForStatus(status),
      child: Text(
        (initial.isNotEmpty ? initial[0] : '?'),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  static Color colorForStatus(String status) {
    switch (status.toLowerCase()) {
      case 'стабилен':
        return Colors.green;
      case 'под наблюдением':
        return Colors.orange;
      case 'критический':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}


