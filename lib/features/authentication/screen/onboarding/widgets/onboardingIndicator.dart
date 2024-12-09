import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/authentication/data/onboarding/onboardingPageData.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/device/device.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../controller/onboarding/onboardingController.dart';

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    final dark = Helper.isDarkMode(context);

    return Positioned(
      bottom: Device.getBottomNavBarHeight(),
      width: Helper.screenWidth(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSpace
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                  controller: controller.pageController,
                  onDotClicked: controller.indicatorClick,
                  count: onboardingPageCount,
                  effect: ExpandingDotsEffect(
                      activeDotColor: dark ? Colors.blue[400]! : Colors.blue[500]!,
                      dotWidth: 8,
                      dotHeight: 4
                  )
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const CircleBorder(),
                      side: BorderSide.none,
                      backgroundColor: dark ? Colors.blue[900]!.withOpacity(0.5) : Colors.blue[50]!,
                      shadowColor: Colors.transparent,
                  ),
                  onPressed: controller.nextPage,
                  child: Icon(
                      IconsaxPlusLinear.arrow_right_3,
                      color: dark ? Colors.blue[400]! : Colors.blue[500]!
                  )
              ),
            ]
        ),
      ),
    );
  }
}