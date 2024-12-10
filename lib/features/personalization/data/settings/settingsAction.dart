import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/common/widgets/personalization/settingItem.dart';
import 'package:product_catalogue/data/repository/authentication/authenticationRepository.dart';

import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/popup/loading.dart';
import '../../screen/change_name/changeName.dart';

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
    title: Strings.updatePhoneNumber,
    onTap: (){},
  ),
  SettingItem(
    title: Strings.changeAddress,
    onTap: (){},
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
          actionsPadding: EdgeInsets.all(
              CustomSize.defaultSpace
          ),
          title: Text(Strings.logout),
          content: Text(Strings.logoutPrompt),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(Get.context!).pop(),
              child: Text(
                  Strings.cancel,
                  style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey
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
                color: Colors.red,
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
                    style: Theme.of(Get.context!).textTheme.titleMedium
                ),
              ),
            ),
          ],
        ),
      );
    },
  ),
];