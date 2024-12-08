import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:product_catalogue/utils/constant/icons.dart';

import '../../../utils/constant/size.dart';
import '../../../utils/helper/helper.dart';

class AlternativeSignIn extends StatelessWidget {
  const AlternativeSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: dark ? Colors.grey[700]! : Colors.grey[300]!
              ),
              shape: BoxShape.circle
          ),
          child: IconButton(
              onPressed: () {
                // TODO: Navigate to login screen with google
              },
              icon: SvgPicture.asset(
                CustomIcon.logoGoogle,
                height: CustomSize.iconMd,
                width: CustomSize.iconMd,
              )
          ),
        )
      ],
    );
  }
}