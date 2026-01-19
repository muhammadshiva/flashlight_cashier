import 'package:flutter/material.dart';

class CustomSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.red,
    VoidCallback? onRetry,
    String retryLabel = 'Retry',
    Duration duration = const Duration(seconds: 3),
  }) {
    final messenger = ScaffoldMessenger.of(context);

    // Clear any existing snackbars before showing new one
    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating, // Make it less intrusive
        margin: const EdgeInsets.all(16),
        duration: duration,
        action: onRetry != null
            ? SnackBarAction(
                label: retryLabel,
                textColor: Colors.white,
                onPressed: onRetry,
              )
            : null,
      ),
    );

    // Failsafe: Explicitly hide snackbar after duration
    // This ensures it disappears even if the framework/scaffold state is complex
    Future.delayed(duration, () {
      try {
        messenger.hideCurrentSnackBar();
      } catch (_) {
        // Ignore errors if widget is disposed
      }
    });
  }
}
