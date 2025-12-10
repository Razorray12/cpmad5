import 'package:flutter/material.dart';
import '../../../core/models/patient.dart';

/// Аватар с инициалом и цветом по статусу.
/// Поддерживает как строковый статус, так и enum PatientStatus.
class StatusAvatar extends StatelessWidget {
  final String initial;
  final dynamic status; // String или PatientStatus

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

  /// Получить цвет для статуса.
  /// Поддерживает как String, так и PatientStatus.
  static Color colorForStatus(dynamic status) {
    if (status is PatientStatus) {
      switch (status) {
        case PatientStatus.stable:
          return Colors.green;
        case PatientStatus.observation:
          return Colors.orange;
        case PatientStatus.critical:
          return Colors.red;
      }
    }
    
    // Fallback для строкового статуса
    final statusStr = status.toString().toLowerCase();
    if (statusStr.contains('стабилен') || statusStr == 'stable') {
      return Colors.green;
    } else if (statusStr.contains('наблюдением') || statusStr == 'observation') {
      return Colors.orange;
    } else if (statusStr.contains('критический') || statusStr == 'critical') {
      return Colors.red;
    }
    return Colors.grey;
  }
}
