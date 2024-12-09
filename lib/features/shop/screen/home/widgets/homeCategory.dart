import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';

class ProductCategory extends StatelessWidget {
  const ProductCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSpace - 4,
          ),
          child: ButtonsTabBar(
            backgroundColor: dark ? Colors.blue[400] : Colors.blue[500],
            unselectedBackgroundColor: dark ? Colors.black : Colors.white,
            radius: 12,
            contentPadding: const EdgeInsets.symmetric(
                horizontal: 8
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              color: dark ? Colors.blue[400] : Colors.blue[500],
            ),
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: dark ? Colors.black : Colors.white,
            ),
            tabs: const [
              Tab(icon: Icon(IconsaxPlusBold.menu)),
              Tab(text: Strings.placeholder),
              Tab(text: Strings.placeholder),
              Tab(text: Strings.placeholder),
              Tab(text: Strings.placeholder),
            ],
          ),
        ),
      ),
    );
  }
}