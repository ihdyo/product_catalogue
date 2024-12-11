import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/shop/productCategory.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/controller/home/categoryController.dart';
import 'package:product_catalogue/features/shop/data/home/homeCarouselData.dart';
import 'package:product_catalogue/features/shop/screen/category_detail/categoryDetail.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeAppBar.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeRecent.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeSearchBar.dart';

import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';
import '../../data/home/homeRecentData.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: dark ? Colors.blue[400] : Colors.blue[500],
        child: Icon(
          IconsaxPlusLinear.add_square,
          color: dark ? Colors.black : Colors.white,
        ),
      ),
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
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      CustomTitle(
                          title: Strings.recentlyViewed
                      ),
                      RecentlyViewed(
                        images: homeRecentList[0].images,
                      ),
                    ],
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
        ], body: Container(

        ),
      ),
    );
  }
}