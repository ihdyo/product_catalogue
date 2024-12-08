import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(
      CustomSize.appBarHeight
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
            const SizedBox(
                height: CustomSize.xs2
            ),
            Text(
              Strings.developer,
              style: Theme.of(context).textTheme.headlineSmall
            ),
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
              // TODO: Cart
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