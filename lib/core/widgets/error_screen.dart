import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({String? errorMessage, this.onPressed, super.key})
      : errorMessage = errorMessage ?? "Unknown Error Occoured";

  final String errorMessage;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Oops! Something went wrong.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            Text(
              "Here is what happened \n$errorMessage",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}
