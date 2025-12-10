import 'package:flutter/material.dart';

/// Каркас диалога с формой: заголовок, контент и стандартные действия
class DialogFormScaffold<TFormState extends State<StatefulWidget>> extends StatelessWidget {
  final String title;
  final GlobalKey<TFormState> formKey;
  final Widget child;
  final String cancelLabel;
  final String submitLabel;
  final VoidCallback onSubmit;

  const DialogFormScaffold({
    super.key,
    required this.title,
    required this.formKey,
    required this.child,
    required this.onSubmit,
    this.cancelLabel = 'Отмена',
    this.submitLabel = 'Сохранить',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: child,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancelLabel),
        ),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text(submitLabel),
        ),
      ],
    );
  }
}


