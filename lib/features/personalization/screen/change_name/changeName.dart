import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/personalization/screen/change_name/widgets/changeNameForm.dart';
import 'package:product_catalogue/utils/constant/images.dart';
import 'package:product_catalogue/utils/constant/size.dart';

import '../../../../common/styles/spacing.dart';
import '../../../../utils/constant/strings.dart';
import '../../../authentication/screen/onboarding/widgets/onboardingPage.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

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
                      image: Images.placeholderPage2,
                      title: Strings.changeName,
                      body: Strings.changeNamePrompt,
                      color: Colors.lightBlue,
                    ),
                    const SizedBox(height: CustomSize.spaceBetweenSections),
                    ChangeNameForm(),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}