import 'package:flutter/material.dart';

import '../../utils/constant/size.dart';

class CircularStacked extends StatelessWidget {
  const CircularStacked({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: -8,
          bottom: -48,
          child: Container(
            width: CustomSize.imageCarouselHeight * 0.5,
            height: CustomSize.imageCarouselHeight * 0.5,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -36,
          bottom: -80,
          child: Container(
            width: CustomSize.imageCarouselHeight,
            height: CustomSize.imageCarouselHeight,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -56,
          bottom: -96,
          child: Container(
            width: CustomSize.imageCarouselHeight * 1.5,
            height: CustomSize.imageCarouselHeight * 1.5,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: -64,
          bottom: -124,
          child: Container(
            width: CustomSize.imageCarouselHeight * 2,
            height: CustomSize.imageCarouselHeight * 2,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}