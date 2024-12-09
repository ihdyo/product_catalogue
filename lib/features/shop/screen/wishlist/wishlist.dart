import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../common/widgets/SectionTitle.dart';
import '../../../../common/widgets/shop/productItem.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: dark ? Colors.blue[400] : Colors.blue[500],
          child: Icon(
            IconsaxPlusLinear.add_square,
            color: dark ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(
              top: CustomSize.spaceBetweenSections,
            ),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SectionTitle(
                    title: Strings.wishlist,
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: CustomSize.defaultSpace,
              right: CustomSize.defaultSpace,
              bottom: CustomSize.spaceBetweenSections
            ),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: CustomSize.spaceBetweenItems / 2,
                mainAxisSpacing: CustomSize.spaceBetweenItems / 2,
                childAspectRatio: 2 / 3,
              ),
              delegate: SliverChildBuilderDelegate(
                    (context, index) => ProductItem(),
                childCount: 5, // Replace with dynamic length
              ),
            ),
          ),
        ],
      ),
    );
  }
}