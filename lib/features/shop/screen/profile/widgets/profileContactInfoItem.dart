import 'package:flutter/material.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';

class ContactInfoItem extends StatelessWidget {
  const ContactInfoItem({
    super.key,
    required this.title,
    required this.body,
    required this.icon,
    required this.iconColorDark,
    required this.iconColorLight,
    required this.backgroundColorDark,
    required this.backgroundColorLight
  });

  final String title, body;
  final IconData icon;
  final Color iconColorDark, iconColorLight, backgroundColorDark, backgroundColorLight;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dark ? backgroundColorDark : backgroundColorLight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(
                CustomSize.sm
            ),
            child: Icon(
                icon,
                size: 20,
                color: dark ? iconColorDark : iconColorLight
            ),
          ),
        ),
        const SizedBox(
            width: CustomSize.md
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                title,
                style: Theme.of(context).textTheme.titleMedium
            ),
            Text(
              body.isEmpty ? Strings.notSet : body,
              style: body.isEmpty
                  ? Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic
              )
                  : null,
            ),
          ],
        )
      ],
    );
  }
}