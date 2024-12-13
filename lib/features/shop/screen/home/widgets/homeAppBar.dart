import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../personalization/controller/user/userController.dart';
import '../../../controller/cart/cartController.dart';
import '../../cart/cart.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(
      CustomSize.appBarHeight
  );

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final controller = Get.put(UserController());
    final dark = Helper.isDarkMode(context);

    return AppBar(
      backgroundColor: dark ? Colors.black : Colors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.only(
            left: CustomSize.defaultSpace / 2
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                Strings.welcome,
                style: Theme.of(context).textTheme.labelLarge
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const CustomShimmer(
                  width: CustomSize.defaultSpace * 6,
                  height: CustomSize.defaultSpace,
                  radius: 4,
                );
              } else {
                return Text(
                    controller.user.value.name.split(' ').first,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: dark ? Colors.blue[400] : Colors.blue[500]
                    )
                );
              }
            })
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
              right: CustomSize.defaultSpace / 2
          ),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CartPage(),
                ),
              );
            },
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  IconsaxPlusLinear.shopping_cart,
                ),
                Positioned(
                  right: -16,
                  top: -8,
                  child: Obx(
                        () => cartController.cart.isNotEmpty
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
                        cartController.cart.length.toString(),
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                        : const SizedBox(),
                  ),
                ),
              ]
            )
          ),
        )
      ],
    );
  }
}