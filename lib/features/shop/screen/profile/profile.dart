import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/data/profile/profileOngoingOrder.dart';
import 'package:product_catalogue/features/shop/data/profile/profileOrderHistory.dart';
import 'package:product_catalogue/features/personalization/screen/settings/settings.dart';
import 'package:product_catalogue/features/shop/screen/profile/widgets/profileContactInfoList.dart';

import '../../../../common/widgets/personalization/orderHistoryItem.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: CustomSize.spaceBetweenSections
          ),
          child: Column(
            children: [
              CustomTitle(
                  title: Strings.profile,
                  isSection: false,
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
                  ),
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: CustomSize.defaultSpace,
                    ),
                    child: ContactInfo(),
                  ),
                ]
              ),
              Visibility(
                visible: true,
                child: Column(
                  children: [
                    CustomTitle(
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
                            orderId: index.toString(),
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
                  CustomTitle(
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
                            orderId: index.toString(),
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
      ),
    );
  }
}