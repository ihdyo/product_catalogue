import 'package:flutter/material.dart';

import '../../utils/helper/helper.dart';

class CircularBackground extends StatelessWidget {
  const CircularBackground({
    super.key,
    required this.color
  });

  final MaterialColor color;

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
              color: dark ? color[900]!.withOpacity(0.5) : color[50],
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
              color: dark ? color[800]!.withOpacity(0.7) : color[200],
              shape: BoxShape.circle,
            ),
          ),
        ),
        TweenAnimationBuilder<double>(
          tween: Tween(
              begin: 0,
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
            width: Helper.screenWidth() * 0.5,
            height: Helper.screenWidth() * 0.5,
            decoration: BoxDecoration(
              color: dark ? color[400]!.withOpacity(0.9) : color[500],
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}