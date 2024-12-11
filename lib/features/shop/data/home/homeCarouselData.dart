import 'package:flutter/material.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeCarouselItem.dart';

import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/strings.dart';

final List<CarouselItem> homeCarouselList = [
  CarouselItem(
    title: Strings.bannerTitle1,
    body: Strings.bannerBody1,
    image: Images.placeholderCarousel1,
    color: Colors.orange,
  ),
  CarouselItem(
    title: Strings.bannerTitle2,
    body: Strings.bannerBody2,
    image: Images.placeholderCarousel2,
    color: Colors.blue,
  ),
  CarouselItem(
    title: Strings.bannerTitle3,
    body: Strings.bannerBody3,
    image: Images.placeholderCarousel3,
    color: Colors.red,
  ),
];