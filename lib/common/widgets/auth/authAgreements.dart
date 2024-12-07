import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../test/notImplemented.dart';

class Agreements extends StatelessWidget {
  const Agreements({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CustomSize.defaultSpace),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: Strings.agreements,
          style: Theme.of(context).textTheme.bodySmall,
          children: [
            const TextSpan(
              text: '\n',
            ),
            TextSpan(
              text: Strings.termsOfService,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO: Terms of Service
                  NotImplementedAlert.show(
                    context,
                    message: Strings.notImplemented,
                  );
                },
            ),
            TextSpan(
              text: ' and ',
            ),
            TextSpan(
              text: Strings.privacyPolicy,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // TODO: Privacy Policy
                  NotImplementedAlert.show(
                    context,
                    message: Strings.notImplemented,
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}