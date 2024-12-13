import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';
import 'package:product_catalogue/common/widgets/shop/temporaryCounter.dart';
import 'package:product_catalogue/utils/formatter/formatter.dart';

import '../../../../../common/widgets/shop/productCategory.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../controller/home/categoryController.dart';
import '../../../controller/home/productController.dart';
import '../../category_detail/categoryDetail.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final categoryController = Get.put(CategoryController());
    final dark = Helper.isDarkMode(context);

    categoryController.fetchCategoryById(productController.productById.value.categoryId);

    return Padding(
      padding: const EdgeInsets.only(
        left: CustomSize.defaultSpace,
        right: CustomSize.defaultSpace,
        bottom: CustomSize.spaceBetweenSections,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (productController.isLoading.value) {
                      return const CustomShimmer(
                        width: CustomSize.defaultSpace * 8,
                        height: CustomSize.defaultSpace,
                        radius: 4,
                      );
                    } else {
                      return Text(
                        productController.productById.value.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      );
                    }
                  }),
                  Obx(() {
                    if (productController.isLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: CustomSize.defaultSpace / 4
                        ),
                        child: const CustomShimmer(
                          width: CustomSize.defaultSpace * 6,
                          height: CustomSize.defaultSpace,
                          radius: 4,
                        ),
                      );
                    } else {
                      return Text(
                        Formatter.formatCurrency(productController.productById.value.price),
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: dark ? Colors.blue[400] : Colors.blue[500],
                            fontWeight: FontWeight.w500),
                      );
                    }
                  }),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Obx(() {
                    if (productController.isLoading.value) {
                      return CustomShimmer(
                        width: CustomSize.defaultSpace * 2,
                        height: CustomSize.defaultSpace / 2,
                        radius: 4,
                      );
                    } else {
                      return Text(
                        Strings.stock,
                        style: Theme.of(context).textTheme.labelMedium,
                      );
                    }
                  }),
                  Obx(() {
                    if (productController.isLoading.value) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: CustomSize.defaultSpace /  8
                        ),
                        child: const CustomShimmer(
                          width: CustomSize.defaultSpace,
                          height: CustomSize.defaultSpace / 2,
                          radius: 4,
                        ),
                      );
                    } else {
                      return Text(
                        productController.productById.value.stock.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                      );
                    }
                  }),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: CustomSize.defaultSpace,
          ),
          // Use Obx to update the category information reactively
          Obx(
            () {
              if (categoryController.isLoading.value) {
                return CustomShimmer(
                  width: CustomSize.defaultSpace * 5,
                  height: CustomSize.defaultSpace * 1.5,
                  radius: 8,
                );
              } else {
                return CategoryItem(
                  name: categoryController.categoryById.value.name,
                  icon: categoryController.categoryById.value.icon,
                  color: categoryController.categoryById.value.color,
                  onClick: () {
                    Navigator.of(Get.context!).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryDetail(
                          categoryId: categoryController.categoryById.value.id,
                          name: categoryController.categoryById.value.name,
                          phrase: categoryController.categoryById.value.phrase,
                          color: categoryController.categoryById.value.color,
                          image: categoryController.categoryById.value.image,
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          const SizedBox(
            height: CustomSize.defaultSpace,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    if (productController.isLoading.value) {
                      return CustomShimmer(
                        width: CustomSize.defaultSpace * 2,
                        height: CustomSize.defaultSpace * 0.75,
                        radius: 4,
                      );
                    } else {
                      return Row(
                        children: [
                          Icon(
                            IconsaxPlusBold.star_1,
                            color: dark ? Colors.yellow[400] : Colors.yellow[500],
                            size: 20,
                          ),
                          const SizedBox(width: CustomSize.xs),
                          Text(
                            productController.productById.value.star.toString(),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      );
                    }
                  }),
                  const SizedBox(height: CustomSize.xs),
                  Obx(() {
                    if (productController.isLoading.value) {
                      return CustomShimmer(
                        width: CustomSize.defaultSpace * 3,
                        height: CustomSize.defaultSpace * 0.5,
                        radius: 4,
                      );
                    } else {
                      return Text(
                        '(${productController.productById.value.reviewer} ${Strings.reviews})',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w400),
                      );
                    }
                  }),
                ],
              ),
              Column(
                children: [
                  TemporaryCounter(
                    id: id,
                    width: CustomSize.defaultSpace * 5,
                    lightColor: Colors.grey[200]!,
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: CustomSize.defaultSpace),
          Obx(() {
            if (productController.isLoading.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomShimmer(
                    width: double.infinity,
                    height: CustomSize.defaultSpace,
                    radius: 4,
                  ),
                  const SizedBox(height: CustomSize.defaultSpace / 4),
                  const CustomShimmer(
                    width: CustomSize.defaultSpace * 10,
                    height: CustomSize.defaultSpace,
                    radius: 4,
                  ),
                ],
              );
            } else {
              return Text(
                  productController.productById.value.description
              );
            }
          }),
        ],
      ),
    );
  }
}