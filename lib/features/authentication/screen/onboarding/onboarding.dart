import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/features/authentication/screen/onboarding/widgets/onboardingIndicator.dart';

import '../../controller/onboarding/onboardingController.dart';
import '../../data/onboarding/onboardingPageData.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
          children: [
            PageView(
                controller: controller.pageController,
                onPageChanged: controller.updatePageIndicator,
                children: onboardingPageList
            ),
            const OnboardingIndicator(),
          ]
      ),
    );
  }
}