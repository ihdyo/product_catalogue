import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/personalization/settingItem.dart';
import 'package:product_catalogue/data/repository/authentication/authenticationRepository.dart';

import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';
import '../../../../utils/popup/loading.dart';
import '../../screen/change_address/changeAddress.dart';
import '../../screen/change_name/changeName.dart';
import '../../screen/change_phone/changePhone.dart';

final dark = Helper.isDarkMode(Get.context!);

final List<SettingItem> settingsActionList = [
  SettingItem(
    title: Strings.changeName,
    onTap: (){
      Navigator.of(Get.context!).push(
        MaterialPageRoute(
          builder: (context) => ChangeName(),
        ),
      );
    },
  ),
  SettingItem(
    title: Strings.changePhone,
    onTap: (){
      Navigator.of(Get.context!).push(
        MaterialPageRoute(
          builder: (context) => ChangePhone(),
        ),
      );
    },
  ),
  SettingItem(
    title: Strings.changeAddress,
    onTap: (){
      Navigator.of(Get.context!).push(
        MaterialPageRoute(
          builder: (context) => ChangeAddress(),
        ),
      );
    },
  ),
  SettingItem(
    title: Strings.logout,
    isDanger: true,
    onTap: () {
      showDialog(
        context: Get.context!,
        builder: (_) => AlertDialog(
          insetPadding: EdgeInsets.all(
              CustomSize.defaultSpace
          ),
          contentPadding: EdgeInsets.all(
              CustomSize.defaultSpace
          ),
          title: Row(
            children: [
              Icon(
                IconsaxPlusLinear.logout
              ),
              SizedBox(
                  width: CustomSize.defaultSpace / 2
              ),
              Text(
                  Strings.logout
              ),
            ],
          ),
          content: Text(Strings.logoutPrompt),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(Get.context!).pop(),
              child: Text(
                  Strings.cancel,
                  style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: dark ? Colors.grey[400] : Colors.grey[600],
                  )
              ),
            ),
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: CustomSize.defaultSpace / 2,
                vertical: 0
              ),
              decoration: BoxDecoration(
                color: dark ? Colors.red[400] : Colors.red[500],
                borderRadius: BorderRadius.circular(
                    CustomSize.defaultSpace
                ),
              ),
              child: TextButton(
                onPressed: () {
                  AuthenticationRepository.instance.logout();
                  Loading.errorSnackBar(
                      title: Strings.logout,
                      message: Strings.logoutMessage
                  );
                },
                child: Text(
                    Strings.logout,
                    style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                      color: dark ? Colors.black : Colors.white,
                    )
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
];