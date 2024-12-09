import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/personalization/data/profile/proffileOngoingOrder.dart';
import 'package:product_catalogue/features/personalization/data/profile/profileContact.dart';
import 'package:product_catalogue/features/personalization/data/profile/profileOrderHistory.dart';
import 'package:product_catalogue/features/personalization/screen/profile/widgets/profileContactInfo.dart';
import 'package:product_catalogue/features/personalization/screen/settings/settings.dart';

import '../../../../common/widgets/SectionTitle.dart';
import '../../../../common/widgets/personalization/orderHistoryItem.dart';
import '../../../../utils/constant/images.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CustomSize.spaceBetweenSections
        ),
        child: Column(
          children: [
            SectionTitle(
                title: Strings.profile,
                actionWidget: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()
                        )
                    );
                  },
                  child: Icon(
                    IconsaxPlusBold.setting,
                  ),
                )
            ),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CustomSize.defaultSpace
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => SizedBox(
                        height: CustomSize.spaceBetweenItems
                    ),
                    itemCount: contactInfoList.length,
                    itemBuilder: (context, index) {
                      return ContactInfoItem(
                        icon: contactInfoList[index].icon,
                        title: contactInfoList[index].title,
                        body: contactInfoList[index].body,
                        iconColorDark: contactInfoList[index].iconColorDark,
                        iconColorLight: contactInfoList[index].iconColorLight,
                        backgroundColorDark: contactInfoList[index].backgroundColorDark,
                        backgroundColorLight: contactInfoList[index].backgroundColorLight,
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Image(
                      width: Helper.screenWidth() * 0.5,
                      image: AssetImage(
                        Images.placeholderUser
                      ),
                  ),
                )
              ]
            ),
            Visibility(
              visible: true,
              child: Column(
                children: [
                  SectionTitle(
                      title: Strings.ongoingOrder
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
                      itemCount: ongoingOrderList.length,
                      itemBuilder: (context, index) {
                        return OrderHistoryItem(
                          date: ongoingOrderList[index].date,
                          status: ongoingOrderList[index].status,
                          itemCount: ongoingOrderList[index].itemCount,
                          totalPrice: ongoingOrderList[index].totalPrice
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: [
                SectionTitle(
                    title: Strings.orderHistory
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
                    itemCount: orderHistoryList.length,
                    itemBuilder: (context, index) {
                      return OrderHistoryItem(
                          date: orderHistoryList[index].date,
                          status: orderHistoryList[index].status,
                          itemCount: orderHistoryList[index].itemCount,
                          totalPrice: orderHistoryList[index].totalPrice
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}