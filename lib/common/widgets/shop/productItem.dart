import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../utils/constant/images.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/helper/helper.dart';
import '../../styles/shadow.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    ShadowStyle().shadowMedium()
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    Images.placeholder,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
              Positioned(
                top: CustomSize.defaultSpace / 4,
                right: CustomSize.defaultSpace / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: const Icon(
                        IconsaxPlusLinear.heart
                    ),
                    color: dark ? Colors.red[400] : Colors.red[500],
                    onPressed: () {},
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                      bottom: CustomSize.defaultSpace / 4,
                      left: CustomSize.defaultSpace / 4,
                      right: CustomSize.defaultSpace / 4
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          IconsaxPlusLinear.minus,
                          color: dark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        Strings.counter,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          IconsaxPlusLinear.add,
                          color: dark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: CustomSize.defaultSpace / 4,
            left: CustomSize.defaultSpace / 4,
            bottom: CustomSize.defaultSpace / 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.placeholder,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: dark ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              Text(
                Strings.developer,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}