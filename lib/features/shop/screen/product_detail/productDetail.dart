import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';
import 'package:product_catalogue/features/shop/controller/product_detail/productDetailController.dart';
import 'package:product_catalogue/features/shop/controller/temporary/temporaryController.dart';
import 'package:product_catalogue/features/shop/screen/cart/cart.dart';
import 'package:product_catalogue/features/shop/screen/product_detail/widgets/productDetailDetail.dart';
import 'package:product_catalogue/utils/constant/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/styles/InverseRound.dart';
import '../../../../common/styles/shadow.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';
import '../../controller/home/productController.dart';
import '../../controller/home/recentController.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.id
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final recentController = Get.find<RecentController>();
    final productController = ProductController.instance;
    final temporaryController = TemporaryController.instance;
    final imageController = Get.put(ProductDetailController());
    final dark = Helper.isDarkMode(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductById(id);
      recentController.addItem(id);
    });

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          productController.fetchProductsByIds(recentController.recentItems);
        }
      },
      child: Obx(
          () => productController.isLoading.value ?
          const Center(child: CircularProgressIndicator())
          : Scaffold(
          body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipPath(
                            clipper: InverseCurvedEdge(),
                            child: AspectRatio(
                              aspectRatio: 4 / 5,
                              child: PageView(
                                controller: imageController.pageController,
                                onPageChanged: imageController.updatePageIndicator,
                                children: [
                                  for (var image in productController.productById.value.images)
                                    Image.network(
                                        image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const CustomShimmer(
                                                width: double.infinity,
                                                height: double.infinity
                                            );
                                          }
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                              Images.placeholder,
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover
                                          );
                                        }
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: CustomSize.defaultSpace * 2,
                            left: CustomSize.defaultSpace,
                            right: CustomSize.defaultSpace,
                            child: Center(
                              child: SmoothPageIndicator(
                                  controller: imageController.pageController,
                                  count: productController.productById.value.images.length,
                                  onDotClicked: imageController.indicatorClick,
                                  effect: ExpandingDotsEffect(
                                      activeDotColor: dark ? Colors.white : Colors.black,
                                      dotWidth: 4,
                                      dotHeight: 4
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      ProductDetail(
                        id: id,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: CustomSize.appBarHeight,
                    left: CustomSize.defaultSpace,
                    right: CustomSize.defaultSpace,
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(
                              CustomSize.defaultSpace / 2
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dark ? Colors.black : Colors.white,
                            boxShadow: [
                              ShadowStyle().shadowSmall()
                            ],
                          ),
                          child:
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                                IconsaxPlusLinear.arrow_left,
                                color: dark ? Colors.white : Colors.black
                            ),
                          )
                      ),
                      const Spacer(),
                      Container(
                          padding: const EdgeInsets.all(
                              CustomSize.defaultSpace / 2
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dark ? Colors.black : Colors.white,
                            boxShadow: [
                              ShadowStyle().shadowSmall()
                            ],
                          ),
                          child:
                          Obx(() {
                            bool isWishlist = productController.isProductInWishlist(id);
                            return GestureDetector(
                              onTap: () {
                                isWishlist
                                    ? productController.removeProductFromWishlist(id)
                                    : productController.addProductToWishlist(id);
                              },
                              child: Icon(
                                isWishlist ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
                                color: dark ? Colors.red[400] : Colors.red[500],
                              ),
                            );
                          }),
                      ),
                    ],
                  ),
                )
              ]
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CustomSize.defaultSpace / 2,
                horizontal: CustomSize.defaultSpace
            ),
            child: Obx(() {
              final isAvailable = productController.productById.value.stock >= temporaryController.getProductQuantityById(id);

              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: !isAvailable ? null : () {
                        // TODO Buy
                      },
                      child: Text(
                        Strings.buyButton,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: dark ? Colors.black : Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: CustomSize.defaultSpace / 2
                  ),
                  ElevatedButton(
                    onPressed: !isAvailable ? null : () {
                      // TODO Buy
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(CustomSize.defaultSpace * 0.6),
                        backgroundColor: dark ? Colors.blue[900]!.withOpacity(0.5) : Colors.blue[50],
                        elevation: 0,
                        side: BorderSide.none,
                        shadowColor: Colors.transparent,
                        disabledIconColor: dark ? Colors.grey[400] : Colors.grey[500],
                        iconColor: dark ? Colors.blue[400] : Colors.blue[500]
                    ),
                    child: Icon(
                        IconsaxPlusLinear.shopping_cart
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}