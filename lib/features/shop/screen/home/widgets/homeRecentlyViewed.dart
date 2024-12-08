import 'package:flutter/material.dart';

import '../../../../../common/styles/shadow.dart';
import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/size.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSize.imageCarouselHeight * 1.25,
      width: double.infinity,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: CustomSize.defaultSpace - (CustomSize.spaceBetweenItems / 4),
        ),
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CustomSize.spaceBetweenItems / 4,
            ),
            child: Container(
              width: CustomSize.imageCarouselHeight * 1.25 * (4 / 5),
              height: CustomSize.imageCarouselHeight * 1.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  ShadowStyle().shadowMedium()
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
          );
        },
      ),
    );
  }
}