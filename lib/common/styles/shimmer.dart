import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/helper/helper.dart';


class CustomShimmer extends StatelessWidget {
  const CustomShimmer({
    super.key,
    required this.width,
    required this.height,
    this.radius = 16,
    this.color,
  });

  final double width, height, radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);
    return Shimmer.fromColors(
      baseColor: dark ? Colors.grey[700]! : Colors.grey[300]!,
      highlightColor: dark ? Colors.grey[800]! : Colors.grey[200]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (dark ? Colors.grey[800] : Colors.grey[200]),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
