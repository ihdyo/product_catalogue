import 'package:flutter/material.dart';

import '../../utils/helper/helper.dart';

class CircularBackground extends StatelessWidget {
  const CircularBackground({
    super.key,
    required this.darkOuterColor,
    required this.lightOuterColor,
    required this.darkInnerColor,
    required this.lightInnerColor,
  });

  final Color darkOuterColor;
  final Color lightOuterColor;
  final Color darkInnerColor;
  final Color lightInnerColor;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Stack(
      alignment: Alignment.center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(
              begin: 0.5,
              end: 1
          ),
          duration: const Duration(
              milliseconds: 800
          ),
          curve: Curves.easeOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            width: Helper.screenWidth(),
            height: Helper.screenWidth(),
            decoration: BoxDecoration(
              color: dark ? darkOuterColor : lightOuterColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(
              begin: 0.25,
              end: 1
          ),
          duration: const Duration(
              milliseconds: 800
          ),
          curve: Curves.easeOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: Container(
            width: Helper.screenWidth() * 0.7,
            height: Helper.screenWidth() * 0.7,
            decoration: BoxDecoration(
              color: dark ? darkInnerColor : lightInnerColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}