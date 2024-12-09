import 'package:flutter/material.dart';

import '../../../../../common/styles/shadow.dart';
import '../../../../../utils/constant/size.dart';

class RecentlyViewed extends StatelessWidget {
  const RecentlyViewed({
    super.key,
    required this.images
  });

  final Map<String, String> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomSize.imageCarouselHeight,
      width: double.infinity,
      child: ListView.separated(
        itemCount: images.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: CustomSize.defaultSpace,
        ),
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: CustomSize.spaceBetweenItems / 2,
          );
        },
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 4 / 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  ShadowStyle().shadowMedium()
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  images.values.toList()[index],
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