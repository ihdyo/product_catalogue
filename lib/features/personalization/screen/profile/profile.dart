import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/personalization/screen/profile/widgets/profileContactInfoList.dart';
import 'package:product_catalogue/features/shop/controller/order/orderController.dart';
import 'package:product_catalogue/features/personalization/screen/settings/settings.dart';
import 'package:product_catalogue/utils/formatter/formatter.dart';

import '../../../../common/widgets/personalization/orderHistoryItem.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.put(OrderController());

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
                      IconsaxPlusLinear.setting,
                    ),
                  ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomSize.defaultSpace,
                ),
                child: ContactInfo(),
              ),
              const SizedBox(height: CustomSize.spaceBetweenSections),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomSize.defaultSpace
                ),
                child: Obx(
                      () => ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (_, __) => SizedBox(
                        height: CustomSize.spaceBetweenItems / 2
                    ),
                    itemCount: orderController.ongoingOrder.length,
                    itemBuilder: (context, index) {
                      return OrderHistoryItem(
                          orderId: orderController.ongoingOrder[index].id,
                          date: Formatter.formatDate(orderController.ongoingOrder[index].date),
                          status: orderController.ongoingOrder[index].status,
                          totalPrice: orderController.ongoingOrder[index].totalPrice
                      );
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  CustomTitle(
                      title: Strings.completeOrder
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSize.defaultSpace
                    ),
                    child: Obx(
                          () => ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => SizedBox(
                            height: CustomSize.spaceBetweenItems / 2
                        ),
                        itemCount: orderController.completedOrder.length,
                        itemBuilder: (context, index) {
                          return OrderHistoryItem(
                              orderId: orderController.completedOrder[index].id,
                              date: Formatter.formatDate(orderController.completedOrder[index].date),
                              status: orderController.completedOrder[index].status,
                              totalPrice: orderController.completedOrder[index].totalPrice
                          );
                        },
                      ),
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