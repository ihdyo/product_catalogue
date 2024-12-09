import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/data/home/homeCarouselData.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeAppBar.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeCategory.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeRecent.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeSearchBar.dart';

import '../../../../common/widgets/shop/productItem.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';
import '../../data/home/homeProductData.dart';
import '../../data/home/homeRecentData.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: DefaultTabController(
        length: 5,
        child: NestedScrollView(
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
                  ProductCategory()
                ],
              ),
            ),
          ],
          body: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.builder(
                      padding: const EdgeInsets.only(
                          top: CustomSize.defaultSpace / 2,
                          left: CustomSize.defaultSpace,
                          right: CustomSize.defaultSpace,
                          bottom: CustomSize.spaceBetweenSections
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: CustomSize.spaceBetweenItems / 2,
                        mainAxisSpacing: CustomSize.spaceBetweenItems / 2,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: homeProductList.length,
                      itemBuilder: (context, index) => ProductItem(
                          image: homeProductList[index].image,
                          name: homeProductList[index].name,
                          price: homeProductList[index].price,
                          quantity: homeProductList[index].quantity,
                          isWishlist: homeProductList[index].isWishlist,
                      ),
                    ),
                    Center(
                        child: Text(
                            Strings.placeholder
                        )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}