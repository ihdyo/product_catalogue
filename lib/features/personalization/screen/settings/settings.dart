import 'package:flutter/material.dart';
import 'package:product_catalogue/common/widgets/personalization/settingItem.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/personalization/data/settings/settingsAction.dart';

import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CustomSize.spaceBetweenSections
        ),
        child: Column(
          children: [
            CustomTitle(
                title: Strings.settings,
                hasBackButton: true,
                isSection: false,
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
                    onTap: settingsActionList[index].onTap,
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