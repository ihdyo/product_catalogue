import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/personalization/screen/change_phone/widgets/changePhoneForm.dart';
import 'package:product_catalogue/utils/constant/images.dart';
import 'package:product_catalogue/utils/constant/size.dart';

import '../../../../common/styles/spacing.dart';
import '../../../../utils/constant/strings.dart';
import '../../../authentication/screen/onboarding/widgets/onboardingPage.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

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
                      image: Images.placeholderPage3,
                      title: Strings.changePhone,
                      body: Strings.changePhonePrompt,
                      lightInnerColor: Colors.lightBlue[100]!,
                      lightOuterColor: Colors.lightBlue[50]!,
                      darkInnerColor: Colors.lightBlue[800]!.withOpacity(0.5),
                      darkOuterColor: Colors.lightBlue[900]!.withOpacity(0.5),
                    ),
                    const SizedBox(height: CustomSize.spaceBetweenSections),
                    ChangePhoneForm(),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}