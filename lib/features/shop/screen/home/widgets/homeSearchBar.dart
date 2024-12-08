import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(
          top: CustomSize.defaultSpace,
          left: CustomSize.defaultSpace,
          right: CustomSize.defaultSpace
      ),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: dark ? Colors.grey[800] : Colors.grey[200],
          hintText: Strings.search,
          hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: dark ? Colors.grey[400] : Colors.grey[600]
          ),
          suffixIcon: Icon(
            IconsaxPlusLinear.search_normal_1,
            color: dark ? Colors.grey[300] : Colors.grey[700],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
