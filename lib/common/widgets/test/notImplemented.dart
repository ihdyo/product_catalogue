import 'package:flutter/material.dart';

import '../../../utils/constant/strings.dart';

class NotImplementedAlert {
  static void show(
      BuildContext context, {
        required String message,
        Duration duration = const Duration(
            seconds: 2
        ),
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}