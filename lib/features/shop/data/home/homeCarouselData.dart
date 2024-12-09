import 'package:flutter/material.dart';
import 'package:product_catalogue/features/shop/screen/home/widgets/homeCarouselItem.dart';

import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/strings.dart';

final List<CarouselItem> homeCarouselList = [
  CarouselItem(
    title: Strings.developer,
    body: Strings.placeholder,
    image: Images.placeholderCarousel1,
    darkBackgroundColor: Colors.orange[400]!,
    lightBackgroundColor: Colors.orange[500]!,
  ),
  CarouselItem(
    title: Strings.developer,
    body: Strings.placeholder,
    image: Images.placeholderCarousel2,
    darkBackgroundColor: Colors.lightBlue[400]!,
    lightBackgroundColor: Colors.lightBlue[500]!,
  ),
  CarouselItem(
    title: Strings.developer,
    body: Strings.placeholder,
    image: Images.placeholderCarousel3,
    darkBackgroundColor: Colors.red[400]!,
    lightBackgroundColor: Colors.red[500]!,
  ),
];