import 'package:flutter/material.dart';

void showErrorSnackBar(
  BuildContext context, {
  required String message,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
      showCloseIcon: true,
      margin: const EdgeInsets.all(18),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.9),
    ),
  );
}

void showSuccessSnackBar(
  BuildContext context, {
  required String message,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: const StadiumBorder(),
      showCloseIcon: true,
      margin: const EdgeInsets.all(18),
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 90, 169, 0).withOpacity(0.9),
    ),
  );
}
