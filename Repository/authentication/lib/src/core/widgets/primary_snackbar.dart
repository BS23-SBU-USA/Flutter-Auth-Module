import 'package:auth_module/src/core/theme/extension.dart';
import 'package:flutter/material.dart';

class ShowSnackBarMessage {
  static void showSuccessSnackBar({
    required String message,
    required BuildContext context,
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: seconds),
        content: Center(
          child: Text(
            message,
            style:  TextStyle(color: context.color.onPrimaryContainer, fontSize: 16),
          ),
        ),
        backgroundColor: context.color.primary,
      ),
    );
  }

  static void showErrorSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Center(
          child: Text(
            message,
            style: TextStyle(color: context.color.onPrimaryContainer, fontSize: 16),
          ),
        ),
        backgroundColor: context.color.error,
      ),
    );
  }

  static void showLoadingSnackBar({
    required String message,
    required BuildContext context,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Center(
              child: Text(
                message,
                style: TextStyle(color: context.color.onPrimaryContainer , fontSize: 16),
              ),
            ),
          ],
        ),
        backgroundColor: context.color.primary,
      ),
    );
  }
}
