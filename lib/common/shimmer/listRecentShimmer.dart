import 'package:flutter/material.dart';

import '../../utils/constant/size.dart';
import '../styles/shimmer.dart';

class ListRecentShimmer extends StatelessWidget {
  const ListRecentShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
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
          child: const CustomShimmer(
            width: double.infinity,
            height: double.infinity,
            radius: 16,
          ),
        );
      },
    );
  }
}