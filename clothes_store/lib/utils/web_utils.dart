import 'package:flutter/material.dart';

void showAlert(BuildContext context, String message) {
  // Use a SnackBar to show the alert message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
