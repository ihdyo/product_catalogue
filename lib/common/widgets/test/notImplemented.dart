import 'package:flutter/material.dart';

import '../../../utils/constant/strings.dart';

class NotImplementedAlert {
  static void show(
      BuildContext context, {
        Duration duration = const Duration(
            seconds: 2
        ),
      }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            Strings.notImplemented
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}