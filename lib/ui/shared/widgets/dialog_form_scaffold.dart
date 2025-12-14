import 'package:flutter/material.dart';

/// Каркас диалога с формой: заголовок, контент и стандартные действия
class DialogFormScaffold<TFormState extends State<StatefulWidget>> extends StatefulWidget {
  final String title;
  final GlobalKey<TFormState> formKey;
  final Widget child;
  final String cancelLabel;
  final String submitLabel;
  final dynamic Function() onSubmit; // Может возвращать void или Future

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
  State<DialogFormScaffold<TFormState>> createState() =>
      _DialogFormScaffoldState<TFormState>();
}

class _DialogFormScaffoldState<TFormState extends State<StatefulWidget>>
    extends State<DialogFormScaffold<TFormState>> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;
    
    setState(() => _isSubmitting = true);
    
    try {
      final result = widget.onSubmit();
      if (result is Future) {
        await result;
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: widget.child,
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          child: Text(widget.cancelLabel),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _handleSubmit,
          child: _isSubmitting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(widget.submitLabel),
        ),
      ],
    );
  }
}
