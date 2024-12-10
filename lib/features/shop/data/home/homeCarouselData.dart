import 'package:flutter/material.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeCarouselItem.dart';

import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/strings.dart';

final List<CarouselItem> homeCarouselList = [
  CarouselItem(
    title: Strings.bannerTitle1,
    body: Strings.bannerBody1,
    image: Images.placeholderCarousel1,
    darkBackgroundColor: Colors.orange[400]!,
    lightBackgroundColor: Colors.orange[500]!,
  ),
  CarouselItem(
    title: Strings.bannerTitle2,
    body: Strings.bannerBody2,
    image: Images.placeholderCarousel2,
    darkBackgroundColor: Colors.lightBlue[400]!,
    lightBackgroundColor: Colors.lightBlue[500]!,
  ),
  CarouselItem(
    title: Strings.bannerTitle3,
    body: Strings.bannerBody3,
    image: Images.placeholderCarousel3,
    darkBackgroundColor: Colors.red[400]!,
    lightBackgroundColor: Colors.red[500]!,
  ),
];