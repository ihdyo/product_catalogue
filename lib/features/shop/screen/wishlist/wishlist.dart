import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/common/shimmer/gridSliverProductShimmer.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/authentication/screen/onboarding/widgets/onboardingPage.dart';
import 'package:product_catalogue/features/shop/controller/wishlist/wishlistController.dart';

import '../../../../common/widgets/shop/productItem.dart';
import '../../../../utils/constant/images.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = WishlistController.instance;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishlistController.fetchWishlists();
    });

    return Scaffold(
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
          Obx(() {
            if (wishlistController.isLoading.value) {
              return GridSliverProductShimmer();
            } else if (wishlistController.wishlist.isEmpty) {
              return SliverToBoxAdapter(
                child: OnboardingPage(
                    image: Images.placeholderEmptyWishlist,
                    title: Strings.emptyWishlist,
                    body: Strings.emptyWishlistBody,
                    color: Colors.red
                )
              );
            } else {
              return SliverPadding(
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
                      childCount: wishlistController.wishlist.length,
                          (context, index) => ProductItem(
                        id: wishlistController.wishlist[index].id,
                        image: wishlistController.wishlist[index].images.first,
                        name: wishlistController.wishlist[index].name,
                        price: wishlistController.wishlist[index].price,
                      ),
                    ),
                  )
              );
            }
          }),
        ],
      ),
    );
  }
}