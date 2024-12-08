import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/size.dart';
import '../../../utils/helper/helper.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.body,
    required this.navigateTo,
    required this.navigation
  });

  final String title, body, navigateTo;
  final Widget navigation;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Column(
      children: [
        SizedBox(
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
        RichText(
          text: TextSpan(
            text: body,
            style: Theme.of(context).textTheme.bodySmall,
            children: [
              TextSpan(
                text: navigateTo,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: dark ? Colors.blue[400] : Colors.blue[500],
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => navigation
                        )
                    );
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}