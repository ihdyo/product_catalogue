import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/personalization/settingItem.dart';
import 'package:product_catalogue/features/personalization/data/profile/proffileOngoingOrder.dart';
import 'package:product_catalogue/features/personalization/data/profile/profileContact.dart';
import 'package:product_catalogue/features/personalization/data/profile/profileOrderHistory.dart';
import 'package:product_catalogue/features/personalization/data/settings/settingsAction.dart';
import 'package:product_catalogue/features/personalization/data/settings/settingsAction.dart';
import 'package:product_catalogue/features/personalization/data/settings/settingsAction.dart';
import 'package:product_catalogue/features/personalization/data/settings/settingsAction.dart';
import 'package:product_catalogue/features/personalization/data/settings/settingsAction.dart';
import 'package:product_catalogue/features/personalization/screen/profile/widgets/profileContactInfo.dart';

import '../../../../common/widgets/SectionTitle.dart';
import '../../../../common/widgets/personalization/orderHistoryItem.dart';
import '../../../../utils/constant/images.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CustomSize.spaceBetweenSections
        ),
        child: Column(
          children: [
            SectionTitle(
                title: Strings.settings,
                prefixWidget: Padding(
                  padding: const EdgeInsets.only(
                      right: CustomSize.spaceBetweenItems
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      IconsaxPlusLinear.arrow_left,
                    ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: CustomSize.defaultSpace
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (_, __) => SizedBox(
                    height: CustomSize.spaceBetweenItems / 2
                ),
                itemCount: settingsActionList.length,
                itemBuilder: (context, index) {
                  return SettingItem(
                    title: settingsActionList[index].title,
                    isDanger: settingsActionList[index].isDanger,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}