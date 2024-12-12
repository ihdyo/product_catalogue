import 'package:flutter/material.dart';
import 'package:product_catalogue/common/decoration/circleStacked.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/helper.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem({
    super.key,
    required this.title,
    required this.body,
    required this.image,
    required this.color
  });

  final String title, body, image;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: CustomSize.imageCarouselHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: dark ? color[400] : color[500],
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              CircularStacked(),
              Padding(
                padding: const EdgeInsets.all(CustomSize.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: dark ? Colors.black : Colors.white
                      ),
                    ),
                    Text(
                      body,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: dark ? Colors.black : Colors.white
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            image,
            height: CustomSize.imageCarouselHeight * 1.25,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}