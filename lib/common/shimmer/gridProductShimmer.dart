import 'package:flutter/cupertino.dart';

import '../../utils/constant/size.dart';
import '../styles/shimmer.dart';

class GridProductShimmer extends StatelessWidget {
  const GridProductShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(
        top: CustomSize.defaultSpace,
        right: CustomSize.defaultSpace,
        left: CustomSize.defaultSpace,
        bottom: CustomSize.spaceBetweenSections,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: CustomSize.spaceBetweenItems,
        mainAxisSpacing: CustomSize.spaceBetweenItems,
        childAspectRatio: 3 / 5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
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
    );
  }
}