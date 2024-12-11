import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/personalization/screen/change_address/widgets/changeAddressForm.dart';
import 'package:product_catalogue/utils/constant/images.dart';
import 'package:product_catalogue/utils/constant/size.dart';

import '../../../../common/styles/spacing.dart';
import '../../../../utils/constant/strings.dart';
import '../../../authentication/screen/onboarding/widgets/onboardingPage.dart';

class ChangeAddress extends StatelessWidget {
  const ChangeAddress({super.key});

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
                      image: Images.placeholderPage4,
                      title: Strings.changeAddress,
                      body: Strings.changeAddressPrompt,
                      color: Colors.lightBlue,
                    ),
                    const SizedBox(height: CustomSize.spaceBetweenSections),
                    ChangeAddressForm(),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}