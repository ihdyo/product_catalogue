import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/shimmer/gridSliverProductShimmer.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/controller/wishlist/wishlistController.dart';

import '../../../../common/widgets/shop/productItem.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.put(WishlistController());
    final dark = Helper.isDarkMode(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishlistController.fetchWishlists();
    });

    return Scaffold(
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: dark ? Colors.blue[400] : Colors.blue[500],
          child: Icon(
            IconsaxPlusLinear.coin_1,
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
                CustomTitle(
                  title: Strings.wishlist,
                  isSection: false,
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
            sliver: Obx(() {
                if (wishlistController.isLoading.value) {
                  return GridSliverProductShimmer();
                } else {
                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: CustomSize.spaceBetweenItems / 2,
                      mainAxisSpacing: CustomSize.spaceBetweenItems / 2,
                      childAspectRatio: 2 / 3,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      childCount: wishlistController.wishlist.length,
                      (context, index) => ProductItem(
                        id: wishlistController.wishlist[index].id,
                        image: wishlistController.wishlist[index].images.first,
                        name: wishlistController.wishlist[index].name,
                        price: wishlistController.wishlist[index].price,
                        isWishlist: true,
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
