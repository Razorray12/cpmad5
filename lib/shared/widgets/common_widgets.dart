import 'package:flutter/material.dart';

/// Общие виджеты для всего приложения
class CommonWidgets {
  /// Стандартная кнопка с иконкой
  static Widget iconButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ),
    );
  }

  /// Стандартная карточка с заголовком и содержимым
  static Widget card({
    required String title,
    required Widget content,
    List<Widget>? actions,
    EdgeInsets? padding,
  }) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            content,
            if (actions != null) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Стандартный диалог подтверждения
  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String content,
    String confirmText = 'Подтвердить',
    String cancelText = 'Отмена',
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  /// Стандартный индикатор загрузки
  static Widget loadingIndicator({String? message}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(message),
          ],
        ],
      ),
    );
  }

  /// Стандартное сообщение об ошибке
  static Widget errorMessage({
    required String message,
    VoidCallback? onRetry,
  }) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.red.shade700,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Повторить'),
            ),
          ],
        ],
      ),
    );
  }

  /// Стандартный чип для отображения данных
  static Widget dataChip({
    required String label,
    required String value,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: backgroundColor,
      labelStyle: TextStyle(color: textColor),
    );
  }

  /// Стандартный разделитель
  static Widget sectionDivider({String? title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
        const Divider(),
      ],
    );
  }
}
