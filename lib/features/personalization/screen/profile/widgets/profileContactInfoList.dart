import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/personalization/screen/profile/widgets/profileContactInfoItem.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../controller/profile/userController.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());

    return Obx(
      () => Column(
        children: [
          ContactInfoItem(
            title: Strings.name,
            body: controller.user.value.name,
            icon: IconsaxPlusBold.user,
            iconColorDark: Colors.lightBlue[400]!,
            iconColorLight: Colors.lightBlue[500]!,
            backgroundColorDark: Colors.lightBlue[900]!.withOpacity(0.5),
            backgroundColorLight: Colors.lightBlue[50]!,
            isLoading: controller.isLoading.value,
          ),
          const SizedBox(height: CustomSize.defaultSpace),
          ContactInfoItem(
            title: Strings.email,
            body: controller.user.value.email,
            icon: IconsaxPlusBold.sms,
            iconColorDark: Colors.orange[400]!,
            iconColorLight: Colors.orange[500]!,
            backgroundColorDark: Colors.orange[900]!.withOpacity(0.5),
            backgroundColorLight: Colors.orange[50]!,
            isLoading: controller.isLoading.value,
          ),
          const SizedBox(height: CustomSize.defaultSpace),
          ContactInfoItem(
            title: Strings.phoneNumber,
            body: controller.user.value.phoneNumber,
            icon: IconsaxPlusBold.call,
            iconColorDark: Colors.green[400]!,
            iconColorLight: Colors.green[500]!,
            backgroundColorDark: Colors.green[900]!.withOpacity(0.5),
            backgroundColorLight: Colors.green[50]!,
            isLoading: controller.isLoading.value,
          ),
          const SizedBox(height: CustomSize.defaultSpace),
          ContactInfoItem(
            title: Strings.address,
            body: controller.user.value.address,
            icon: IconsaxPlusBold.location,
            iconColorDark: Colors.red[400]!,
            iconColorLight: Colors.red[500]!,
            backgroundColorDark: Colors.red[900]!.withOpacity(0.5),
            backgroundColorLight: Colors.red[50]!,
            isLoading: controller.isLoading.value,
          ),
        ],
      ),
    );
  }
}