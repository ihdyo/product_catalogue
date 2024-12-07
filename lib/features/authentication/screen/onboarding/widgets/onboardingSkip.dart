import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/device/device.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../controller/onboarding/onboardingController.dart';
import '../../../data/onboarding/onboardingPageData.dart';

class OnboardingSkip extends StatelessWidget {
  const OnboardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final dark = Helper.isDarkMode(context);
    final lastIndex = onboardingPageCount - 1;

    return Positioned(
      top: Device.getAppBarHeight(),
      right: 0,
      child: Obx(() {
        return Visibility(
          visible: controller.currentPageIndex.value != lastIndex,
          child: TextButton(
            onPressed: controller.skipPage,
            style: ButtonStyle(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            child: Text(
              Strings.skip,
              style: TextStyle(
                color: dark ? Colors.grey[300]! : Colors.grey[700]!,
                fontSize: 14,
              ),
            ),
          ),
        );
      }),
    );
  }
}