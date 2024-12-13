import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/common/widgets/shop/productCategory.dart';
import 'package:product_catalogue/common/widgets/shop/productItem.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/controller/home/categoryController.dart';
import 'package:product_catalogue/features/shop/data/home/homeCarouselData.dart';
import 'package:product_catalogue/features/shop/screen/category_detail/categoryDetail.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeAppBar.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeRecent.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeSearchBar.dart';

import '../../../../common/shimmer/gridProductShimmer.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../controller/home/productController.dart';
import '../../controller/home/recentController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final productController = Get.find<ProductController>();
    final recentController = Get.put(RecentController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (recentController.recentItems.isNotEmpty) {
        productController.fetchProductsByIds(recentController.recentItems);
        productController.fetchProducts();
      }
    });

    return Scaffold(
      appBar: HomeAppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSearchBar(),
                const SizedBox(
                    height: CustomSize.sm
                ),
                CarouselSlider(
                  items: homeCarouselList,
                  options: CarouselOptions(
                    height: CustomSize.imageCarouselHeight * 1.25,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible: recentController.recentItems.isNotEmpty,
                    child: Column(
                      children: [
                        CustomTitle(
                            title: Strings.recent
                        ),
                        RecentlyViewed(
                          ids: recentController.recentItems,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomTitle(
                    title: Strings.products
                ),
                Obx(() => NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    return true;
                  },
                  child: SizedBox(
                    height: CustomSize.categoryHeight,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomSize.defaultSpace
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: categoryController.categories.length,
                      separatorBuilder: (_, __) => SizedBox(width: CustomSize.spaceBetweenItems / 4),
                      itemBuilder: (context, index) {
                        return CategoryItem(
                          name: categoryController.categories[index].name,
                          icon: categoryController.categories[index].icon,
                          color: categoryController.categories[index].color,
                          onClick: () {
                            Navigator.of(Get.context!).push(
                              MaterialPageRoute(
                                builder: (context) => CategoryDetail(
                                  categoryId: categoryController.categories[index].id,
                                  name: categoryController.categories[index].name,
                                  phrase: categoryController.categories[index].phrase,
                                  color: categoryController.categories[index].color,
                                  image: categoryController.categories[index].image,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )),
              ],
            ),
          ),
        ], body: Obx(
            () => productController.isLoading.value
                ? GridProductShimmer()
                : GridView.builder(
                    padding: const EdgeInsets.only(
                      top: CustomSize.defaultSpace,
                      right: CustomSize.defaultSpace,
                      left: CustomSize.defaultSpace,
                      bottom: CustomSize.spaceBetweenSections,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: CustomSize.spaceBetweenItems,
                      mainAxisSpacing: CustomSize.spaceBetweenItems,
                      childAspectRatio: 3 / 5,
                    ),
                    itemCount: productController.products.length,
                    itemBuilder: (context, index) {
                      return ProductItem(
                        id: productController.products[index].id,
                        image: productController.products[index].images.first,
                        name: productController.products[index].name,
                        price: productController.products[index].price,
                      );
                    },
                  ),
      ),
      ),
    );
  }
}