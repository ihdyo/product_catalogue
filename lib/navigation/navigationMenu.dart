import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/screen/home/home.dart';
import 'package:product_catalogue/features/shop/screen/wishlist/wishlist.dart';

import '../common/styles/shadow.dart';
import '../utils/constant/strings.dart';
import '../utils/helper/helper.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = Helper.isDarkMode(context);

    return Scaffold(
        body: Obx(
                () => controller.screens[controller.currentIndex.value]
        ),
        bottomNavigationBar: Obx(

                () => Container(
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
                      icon: Obx(
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
                      label: Strings.profile,
                    ),
                  ]
              ),
            )
        )
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> currentIndex = 0.obs;

  final screens = [
    const HomePage(),
    const WishlistPage(),
    Container(
      color: Colors.blue,
    )
  ];
}