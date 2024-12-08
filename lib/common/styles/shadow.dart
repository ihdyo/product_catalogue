import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/helper/helper.dart';

class ShadowStyle {
  final dark = Helper.isDarkMode(Get.context!);

  BoxShadow shadowLarge() {
    return BoxShadow(
      color: dark ? Colors.transparent : Colors.black.withOpacity(0.05),
      offset: const Offset(0, 4),
      blurRadius: 24,
    );
  }

  BoxShadow shadowMedium() {
    return BoxShadow(
      color: dark ? Colors.transparent : Colors.black.withOpacity(0.025),
      offset: const Offset(0, 4),
      blurRadius: 12,
    );
  }
}