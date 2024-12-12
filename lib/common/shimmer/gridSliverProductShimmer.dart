import 'package:flutter/material.dart';

import '../../utils/constant/size.dart';
import '../styles/shimmer.dart';

class GridSliverProductShimmer extends StatelessWidget {
  const GridSliverProductShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 4 / 5,
                child: const CustomShimmer(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              const SizedBox(
                height: CustomSize.defaultSpace / 4,
              ),
              const CustomShimmer(
                width: CustomSize.defaultSpace * 6,
                height: CustomSize.defaultSpace * 0.75,
                radius: 8,
              ),
              const SizedBox(
                height: CustomSize.defaultSpace / 4,
              ),
              const CustomShimmer(
                width: CustomSize.defaultSpace * 4,
                height: CustomSize.defaultSpace * 1.25,
                radius: 8,
              ),
            ],
          );
        },
        childCount: 4,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: CustomSize.spaceBetweenItems,
        mainAxisSpacing: CustomSize.spaceBetweenItems,
        childAspectRatio: 3 / 5,
      ),
    );
  }
}