import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/controller/product_detail/productDetailController.dart';
import 'package:product_catalogue/features/shop/screen/cart/cart.dart';
import 'package:product_catalogue/features/shop/screen/product_detail/widgets/productDetailDetail.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/styles/InverseRound.dart';
import '../../../../common/styles/shadow.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';
import '../../controller/home/productController.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.index
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final imageController = Get.put(ProductDetailController());
    final dark = Helper.isDarkMode(context);

    return Scaffold(
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
                              for (var image in productController.products[index].images)
                                Image.network(
                                  image,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
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
                              count: productController.products[index].images.length,
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
                    index: index,
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
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                            IconsaxPlusLinear.heart,
                            color: dark ? Colors.red[400] : Colors.red[500]
                        ),
                      )
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
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                      Strings.buyButton,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: dark ? Colors.black : Colors.white
                      )
                  )
              ),
            ),
            const SizedBox(
                width: CustomSize.defaultSpace / 2
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(Get.context!).push(
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: dark ? Colors.blue[900]!.withOpacity(0.5) : Colors.blue[50],
                  elevation: 0,
                  side: BorderSide.none,
                  shadowColor: Colors.transparent
              ),
              child: Icon(
                  IconsaxPlusLinear.shopping_cart,
                  color: dark ? Colors.blue[400] : Colors.blue[500]
              ),
            )
          ],
        ),
      ),
    );
  }
}