import 'package:flutter/cupertino.dart';

import '../../utils/constant/size.dart';
import '../styles/shimmer.dart';

class CommonListShimmer extends StatelessWidget {
  const CommonListShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => SizedBox(
          height: CustomSize.spaceBetweenItems / 2
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomSize.defaultSpace
          ),
          child: CustomShimmer(
              width: double.infinity,
              height: CustomSize.defaultSpace * 2.5
          ),
        );
      },
    );
  }
}