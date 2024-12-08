import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/data/homeCarouselData.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeAppBar.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeRecentlyViewed.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeSearchBar.dart';

import '../../../../common/widgets/SectionTitle.dart';
import '../../../../common/widgets/shop/productItem.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: Visibility(
        visible: true,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: dark ? Colors.blue[400] : Colors.blue[500],
          child: Icon(
            IconsaxPlusLinear.add_square,
            color: dark ? Colors.black : Colors.white,
          ),
        ),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: Column(
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
                        SectionTitle(
                            title: Strings.recentlyViewed
                        ),
                        RecentlyViewed(),
                      ],
                    ),
                  ),
                  SectionTitle(
                      title: Strings.products
                  ),
                ],
              ),
            ),
          ],
          body: GridView.builder(
              padding: const EdgeInsets.only(
                left: CustomSize.defaultSpace,
                right: CustomSize.defaultSpace,
                bottom: CustomSize.spaceBetweenSections,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: CustomSize.spaceBetweenItems / 2,
                mainAxisSpacing: CustomSize.spaceBetweenItems / 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: 5,
              itemBuilder: (context, index) {
                return ProductItem();
              }
          )
      ),
    );
  }
}