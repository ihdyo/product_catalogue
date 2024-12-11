import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../personalization/controller/profile/userController.dart';
import '../../cart/cart.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(
      CustomSize.appBarHeight
  );

  @override
  Widget build(BuildContext context) {
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
            icon: Icon(
                IconsaxPlusLinear.shopping_cart
            ),
          ),
        )
      ],
    );
  }
}