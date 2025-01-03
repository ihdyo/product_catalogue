import 'package:flutter/material.dart';

import '../../../../../common/decoration/circle.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/helper.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.body,
    required this.color
  });

  final String image, title, body;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
          CustomSize.defaultSpace
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              CircularBackground(
                  color: color
              ),
              Image(
                image: AssetImage(image),
                width: Helper.screenWidth() * 0.75,
              )
            ],
          ),
          const SizedBox(
              height: CustomSize.spaceBetweenSections
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
              height: CustomSize.spaceBetweenItems
          ),
          Text(
            body,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}