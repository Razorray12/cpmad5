import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VerticalStepPage extends StatelessWidget {
  final String title;
  final Widget child;
  final String? nextRoute;
  final String nextLabel;
  final VoidCallback? onNext;
  final Widget? floatingActionButton;
  final bool showNextButton;

  const VerticalStepPage({
    super.key,
    required this.title,
    required this.child,
    this.nextRoute,
    this.nextLabel = 'Далее',
    this.onNext,
    this.floatingActionButton,
    this.showNextButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      floatingActionButton: floatingActionButton == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 72.0),
              child: floatingActionButton,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Column(
        children: [
          Expanded(child: child),
          if (showNextButton)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: onNext != null
                      ? onNext
                      : (nextRoute == null
                          ? null
                          : () => context.push(nextRoute!)),
                  child: Text(nextLabel),
                ),
              ),
            ),
        ],
      ),
    );
  }
}


