import 'package:flutter/material.dart';

import '../../../../utils/constant/images.dart';
import '../../../../utils/constant/strings.dart';
import '../../screen/onboarding/widgets/onboardingPage.dart';

final List<OnboardingPage> onboardingPageList = [
  OnboardingPage(
    image: Images.onboarding1,
    title: Strings.onboardingTitle1,
    body: Strings.onboardingBody1,
    color: Colors.orange,
  ),
  OnboardingPage(
    image: Images.onboarding2,
    title: Strings.onboardingTitle2,
    body: Strings.onboardingBody2,
    color: Colors.lightBlue,
  ),
  OnboardingPage(
    image: Images.onboarding3,
    title: Strings.onboardingTitle3,
    body: Strings.onboardingBody3,
    color: Colors.red,
  )
];

final int onboardingPageCount = onboardingPageList.length;