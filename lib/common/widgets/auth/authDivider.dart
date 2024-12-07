import 'package:flutter/material.dart';

import '../../../utils/constant/strings.dart';
import '../../../utils/helper/helper.dart';

class AuthDivider extends StatelessWidget {
  const AuthDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Divider(
              color: dark ? Colors.grey[700] : Colors.grey[300],
              thickness: 1,
              indent: 36,
              endIndent: 24,
            )
        ),
        Text(
          Strings.otherLoginMethod,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        Flexible(
            child: Divider(
              color: dark ? Colors.grey[700]! : Colors.grey[300]!,
              thickness: 1,
              indent: 24,
              endIndent: 36,
            )
        ),
      ],
    );
  }
}