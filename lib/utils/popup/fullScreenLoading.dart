import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/helper.dart';
import '../loading/animationLoading.dart';

class FullScreenLoading {
  static void openLoadingDialog(String text) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => Container(
        color: Colors.black.withOpacity(0.5),
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
              color: Colors.blue
          ),
        ),
      ),
    );
  }

  static stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
