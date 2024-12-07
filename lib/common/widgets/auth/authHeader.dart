import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/size.dart';

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
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
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