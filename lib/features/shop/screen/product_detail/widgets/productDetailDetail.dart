import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';
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
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final categoryController = Get.put(CategoryController());
    final dark = Helper.isDarkMode(context);

    categoryController.fetchCategoryById(productController.products[index].categoryId);

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
                  Text(
                    productController.products[index].name,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    Formatter.formatCurrency(productController.products[index].price),
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: dark ? Colors.blue[400] : Colors.blue[500],
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Strings.stock,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    productController.products[index].stock.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
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
                  Row(
                    children: [
                      Icon(
                        IconsaxPlusBold.star_1,
                        color: dark ? Colors.yellow[400] : Colors.yellow[500],
                        size: 20,
                      ),
                      const SizedBox(width: CustomSize.xs),
                      Text(
                        productController.products[index].star.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: CustomSize.xs),
                  Text(
                    '(${productController.products[index].reviewer} ${Strings.reviews})',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: dark ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: CustomSize.xs / 2, horizontal: CustomSize.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          IconsaxPlusLinear.minus,
                          color: dark ? Colors.grey[400] : Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: CustomSize.md),
                      Text(
                        Strings.counter,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: dark ? Colors.white : Colors.black),
                      ),
                      const SizedBox(width: CustomSize.md),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          IconsaxPlusLinear.add,
                          color: dark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: CustomSize.defaultSpace),
          Text(productController.products[index].description),
        ],
      ),
    );
  }
}