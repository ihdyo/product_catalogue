import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/shop/addToCartFAB.dart';
import 'package:product_catalogue/features/shop/controller/home/productController.dart';
import 'package:product_catalogue/utils/constant/size.dart';

import '../common/styles/shadow.dart';
import '../features/shop/controller/order/orderController.dart';
import '../features/shop/controller/temporary/temporaryController.dart';
import '../utils/constant/strings.dart';
import '../utils/helper/helper.dart';
import 'controller/navigationController.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();
    final temporaryController = Get.find<TemporaryController>();
    final productController = ProductController.instance;
    final controller = Get.put(NavigationController());
    final dark = Helper.isDarkMode(context);
    final int selectedIndex = Get.arguments ?? 0;

    controller.currentIndex.value = selectedIndex;

    return Scaffold(
        body: Obx(() => controller.screens[controller.currentIndex.value]),
        floatingActionButton: AddToCartFAB(),
        bottomNavigationBar: Obx(() => Container(
          decoration: BoxDecoration(
            boxShadow: [
              ShadowStyle().shadowLarge()
            ],
          ),
          child: NavigationBar(
              height: 56,
              elevation: 0,
              selectedIndex: controller.currentIndex.value,
              onDestinationSelected: (index) => controller.currentIndex.value = index,
              backgroundColor: dark ? Colors.grey[900] : Colors.white,
              indicatorColor: dark ? Colors.blue[900]?.withOpacity(0.5) : Colors.blue[50],
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              destinations: [
                NavigationDestination(
                  icon: Obx(
                          () => controller.currentIndex.value == 0
                          ? Icon(
                        IconsaxPlusBold.home,
                        color: dark ? Colors.blue[400] : Colors.blue[500],
                      )
                          : Icon(
                        IconsaxPlusLinear.home,
                        color: dark ? Colors.blue[400] : Colors.blue[500],
                      )
                  ),
                  label: Strings.home,
                ),
                NavigationDestination(
                  icon: Obx(
                    () => controller.currentIndex.value == 1
                          ? Icon(
                        IconsaxPlusBold.heart,
                        color: dark ? Colors.blue[400] : Colors.blue[500],
                      )
                          : Icon(
                        IconsaxPlusLinear.heart,
                        color: dark ? Colors.blue[400] : Colors.blue[500],
                      )
                  ),
                  label: Strings.wishlist,
                ),
                NavigationDestination(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Obx(
                        () => controller.currentIndex.value == 2
                              ? Icon(
                            IconsaxPlusBold.profile,
                            color: dark ? Colors.blue[400] : Colors.blue[500],
                          )
                              : Icon(
                            IconsaxPlusLinear.profile,
                            color: dark ? Colors.blue[400] : Colors.blue[500],
                          )
                      ),
                      Positioned(
                        right: -16,
                        top: -8,
                        child: Obx(
                          () => orderController.ongoingOrder.isNotEmpty
                              ? Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: CustomSize.xs,
                              vertical: CustomSize.xs / 2,
                            ),
                            decoration: BoxDecoration(
                              color: dark ? Colors.red[400] : Colors.red[500],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: CustomSize.sm,
                              minHeight: CustomSize.xs,
                            ),
                            child: Text(
                              orderController.ongoingOrder.length.toString(),
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                              : const SizedBox(),
                        ),
                      ),
                    ],
                  ),
                  label: Strings.profile,
                ),
              ]
          ),
        )
        )
    );
  }
}