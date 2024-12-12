import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeCarouselItem.dart';

import '../../../../common/widgets/shop/productItem.dart';
import '../../../../utils/constant/size.dart';
import '../../controller/home/productController.dart';

class CategoryDetail extends StatelessWidget {
  const CategoryDetail({
    super.key,
    required this.categoryId,
    required this.name,
    required this.phrase,
    required this.image,
    required this.color
  });

  final String categoryId, name, phrase, image;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchProductsByCategory(categoryId);
    });

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          controller.clearProductById();
        }
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(
                top: CustomSize.appBarHeight,
                left: CustomSize.defaultSpace,
                right: CustomSize.defaultSpace,
              ),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        IconsaxPlusLinear.arrow_left,
                      ),
                    ),
                  ),
                  const SizedBox(height: CustomSize.spaceBetweenSections),
                  CarouselItem(
                    title: name,
                    body: phrase,
                    image: image,
                    color: color,
                  ),
                  const SizedBox(height: CustomSize.spaceBetweenSections),
                ]),
              ),
            ),
            Obx(
            () => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: CustomSize.defaultSpace),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: CustomSize.spaceBetweenItems / 2,
                    mainAxisSpacing: CustomSize.spaceBetweenItems / 2,
                    childAspectRatio: 2 / 3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      return ProductItem(
                        id: controller.productsByCategory[index].id,
                        image: controller.productsByCategory[index].images.first,
                        name: controller.productsByCategory[index].name,
                        price: controller.productsByCategory[index].price,
                        quantity: controller.productsByCategory[index].stock,
                      );
                    },
                    childCount: controller.productsByCategory.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
