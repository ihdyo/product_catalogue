import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/styles/shadow.dart';
import '../../../../../utils/constant/size.dart';
import '../../../controller/home/productController.dart';
import '../../product_detail/productDetail.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({
    super.key,
    required this.ids,
  });

  final List<String> ids;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;

    return SizedBox(
      height: CustomSize.imageCarouselHeight,
      width: double.infinity,
      child: Obx(
        () => ListView.separated(
          itemCount: productController.recentProducts.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSpace,
          ),
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: CustomSize.spaceBetweenItems / 2,
            );
          },
          clipBehavior: Clip.none,
          itemBuilder: (context, index) {
            final recentProduct = productController.recentProducts[index];

            final allProductIndex = productController.products.indexWhere(
                  (product) => product.id == recentProduct.id,
            );

            if (allProductIndex != -1) {
              return AspectRatio(
                aspectRatio: 4 / 5,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      ShadowStyle().shadowMedium(),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            index: allProductIndex,
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        recentProduct.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              // Handle the case where the product wasn't found
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}