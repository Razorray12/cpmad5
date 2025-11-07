import 'package:flutter/material.dart';

class HorizontalStepPage extends StatelessWidget {
  final String title;
  final Widget child;
  final String? nextRoute;
  final String nextLabel;
  final VoidCallback? onNext;

  const HorizontalStepPage({
    super.key,
    required this.title,
    required this.child,
    this.nextRoute,
    this.nextLabel = 'Далее',
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            Expanded(child: child),
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
                          : () => Navigator.pushReplacementNamed(context, nextRoute!)),
                  child: Text(nextLabel),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


