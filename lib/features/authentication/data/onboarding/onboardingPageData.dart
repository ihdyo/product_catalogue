import 'package:flutter/material.dart';

import '../../../../utils/constant/images.dart';
import '../../../../utils/constant/strings.dart';
import '../../screen/onboarding/widgets/onboardingPage.dart';

final List<OnboardingPage> onboardingPageList = [
  OnboardingPage(
    image: Images.onboarding1,
    title: Strings.onboardingTitle1,
    body: Strings.onboardingBody1,
    lightInnerColor: Colors.orange[100]!,
    lightOuterColor: Colors.orange[50]!,
    darkInnerColor: Colors.orange[800]!.withOpacity(0.5),
    darkOuterColor: Colors.orange[900]!.withOpacity(0.5),
  ),
  OnboardingPage(
    image: Images.onboarding2,
    title: Strings.onboardingTitle2,
    body: Strings.onboardingBody2,
    lightInnerColor: Colors.lightBlue[100]!,
    lightOuterColor: Colors.lightBlue[50]!,
    darkInnerColor: Colors.lightBlue[800]!.withOpacity(0.5),
    darkOuterColor: Colors.lightBlue[900]!.withOpacity(0.5),
  ),
  OnboardingPage(
    image: Images.onboarding3,
    title: Strings.onboardingTitle3,
    body: Strings.onboardingBody3,
    lightInnerColor: Colors.red[100]!,
    lightOuterColor: Colors.red[50]!,
    darkInnerColor: Colors.red[800]!.withOpacity(0.5),
    darkOuterColor: Colors.red[900]!.withOpacity(0.5),
  )
];

final int onboardingPageCount = onboardingPageList.length;