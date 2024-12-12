import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/styles/shadow.dart';
import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/size.dart';
import '../../../controller/home/productController.dart';
import '../../../controller/home/recentController.dart';
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
    final recentController = Get.find<RecentController>();

    return SizedBox(
      height: CustomSize.imageCarouselHeight,
      width: double.infinity,
      child: Obx(() {
        return ListView.separated(
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
                          id: productController.recentProducts[index].id,
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      productController.recentProducts[index].images.isNotEmpty
                          ? productController.recentProducts[index].images[0]
                          : Images.placeholder,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
                        return Image.asset(
                          Images.placeholder,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      })
    );
  }
}