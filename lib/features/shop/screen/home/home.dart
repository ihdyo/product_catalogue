import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/data/homeCarouselData.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeAppBar.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeCarouselItem.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeSearchBar.dart';

import '../../../../common/widgets/SectionTitle.dart';
import '../../../../utils/constant/images.dart';
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
      body: SingleChildScrollView(
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
                  autoPlay: true
                )
            ),
            const SizedBox(
                height: CustomSize.spaceBetweenSections
            ),
            SectionTitle(
                title: Strings.recentlyViewed
            ),
            const SizedBox(
                height: CustomSize.spaceBetweenItems
            ),
          ],
        ),
      ),
    );
  }
}