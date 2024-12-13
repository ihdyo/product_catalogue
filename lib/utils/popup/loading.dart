import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/utils/constant/size.dart';

import '../helper/helper.dart';

final dark = Helper.isDarkMode(Get.context!);

class Loading {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(CustomSize.defaultSpace / 2),
          margin: const EdgeInsets.symmetric(horizontal: CustomSize.defaultSpace),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Helper.isDarkMode(Get.context!) ? Colors.grey[900] : Colors.grey[200],
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(Get.context!).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  static successSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: dark ? Colors.black : Colors.white,
      backgroundColor: dark ? Colors.blue[400] : Colors.blue[500],
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
      margin: const EdgeInsets.all(CustomSize.defaultSpace),
      icon: Icon(
          IconsaxPlusLinear.check,
          color: dark ? Colors.black : Colors.white
      ),
    );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: dark ? Colors.black : Colors.white,
      backgroundColor: dark ? Colors.orange[400] : Colors.orange[500],
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(CustomSize.defaultSpace),
      icon: Icon(
          IconsaxPlusLinear.warning_2,
          color: dark ? Colors.black : Colors.white
      ),
    );
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: dark ? Colors.black : Colors.white,
      backgroundColor: dark ? Colors.red[400] : Colors.red[500],
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(CustomSize.defaultSpace),
      icon: Icon(
          IconsaxPlusLinear.alarm,
          color: dark ? Colors.black : Colors.white
      ),
    );
  }
}
