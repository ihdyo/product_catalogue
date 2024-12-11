import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/authentication/screen/forgot_password/widgets/forgotPasswordForm.dart';
import 'package:product_catalogue/utils/constant/images.dart';
import 'package:product_catalogue/utils/constant/size.dart';

import '../../../../common/styles/spacing.dart';
import '../../../../utils/constant/strings.dart';
import '../onboarding/widgets/onboardingPage.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: SpacingStyle.paddingWithAppBarHeight,
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                      IconsaxPlusLinear.close_square
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                    top: CustomSize.appBarHeight
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OnboardingPage(
                      image: Images.placeholderPage1,
                      title: Strings.forgotPassword,
                      body: Strings.forgotPasswordPrompt,
                      color: Colors.red,
                    ),
                    const SizedBox(height: CustomSize.spaceBetweenSections),
                    ForgotPasswordForm(),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}