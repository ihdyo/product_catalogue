import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/styles/shadow.dart';
import 'package:product_catalogue/features/shop/data/homeCarouselData.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeAppBar.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeCarouselItem.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeRecentlyViewed.dart';
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
                  SectionTitle(
                      title: Strings.recentlyViewed
                  ),
                  RecentlyViewed(),
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
              return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                ShadowStyle().shadowMedium(),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.asset(
                                Images.placeholder,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: CustomSize.defaultSpace / 4,
                            left: CustomSize.defaultSpace / 4,
                            bottom: CustomSize.defaultSpace / 4,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                Strings.placeholder,
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: dark ? Colors.grey[300] : Colors.grey[700],
                                ),
                              ),
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                Strings.developer,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: CustomSize.defaultSpace / 4,
                      right: CustomSize.defaultSpace / 4,
                      child: Container(
                        decoration: BoxDecoration(
                          color: dark ? Colors.grey[900] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory
                          ),
                          color: dark ? Colors.red[400] : Colors.red[500],
                          icon: const Icon(
                              IconsaxPlusLinear.heart
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Positioned(
                      top: CustomSize.defaultSpace * 6,
                      right: CustomSize.defaultSpace / 2,
                      child: Container(
                        width: CustomSize.defaultSpace * 6,
                        decoration: BoxDecoration(
                          color: dark ? Colors.grey[900] : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: Text(
                                "-",
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: dark ? Colors.grey[400] : Colors.grey[600]
                                ),
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "0",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                              visualDensity: VisualDensity.compact,
                              icon: Text(
                                "+",
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: dark ? Colors.grey[400] : Colors.grey[600]
                                ),
                              ),
                              onPressed: () {},
                            )
                          ],
                        )
                      ),
                    ),
                  ]
              );
            },
          )
      ),
    );
  }
}