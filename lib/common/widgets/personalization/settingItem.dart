import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../utils/constant/size.dart';
import '../../../utils/helper/helper.dart';
import '../../styles/shadow.dart';

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    this.isDanger = false,
  });

  final String title;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: isDanger ? Colors.transparent : (dark ? Colors.grey[900] : Colors.white),
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDanger ? [] : [
          ShadowStyle().shadowSmall()
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CustomSize.defaultSpace / 2,
            horizontal: CustomSize.defaultSpace / 2
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: isDanger ? Colors.red : (dark ? Colors.white : Colors.black),
                  )
              ),
              if (!isDanger) Icon(
                  IconsaxPlusLinear.arrow_right_3,
                  color: dark ? Colors.grey[400] : Colors.grey[600],
              ),
            ]
        ),
      ),
    );
  }
}