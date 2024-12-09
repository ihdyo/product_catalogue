import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(
          left: CustomSize.defaultSpace,
          right: CustomSize.defaultSpace,
          bottom: CustomSize.spaceBetweenSections
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        Strings.developer,
                        style: Theme.of(context).textTheme.headlineMedium
                    ),
                    Text(
                        Strings.placeholder,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                            color: dark ? Colors.blue[400] : Colors.blue[500],
                            fontWeight: FontWeight.w500
                        )
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        Strings.stock
                        ,
                        style: Theme.of(context).textTheme.labelMedium
                    ),
                    Text(
                        Strings.counter,
                        style: Theme.of(context).textTheme.titleMedium
                    ),
                  ],
                ),
              ]
          ),
          const SizedBox(
            height: CustomSize.defaultSpace,
          ),
          Container(
            decoration: BoxDecoration(
              color: dark ? Colors.blue[900]!.withOpacity(0.5) : Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: CustomSize.xs,
                horizontal: CustomSize.sm,
              ),
              child: Text(
                Strings.placeholder,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: dark ? Colors.blue[400] : Colors.blue[500],
                    fontWeight: FontWeight.w500
                ),
              ),
            ),
          ),
          const SizedBox(
            height: CustomSize.defaultSpace,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                          IconsaxPlusBold.star,
                          color: dark ? Colors.yellow[400] : Colors.yellow[500],
                          size: 16
                      ),
                      Text(
                          Strings.developer,
                          style: Theme.of(context).textTheme.labelMedium
                      )
                    ],
                  ),
                  Text(
                      Strings.placeholder,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w400
                      )
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: dark
                      ? Colors.grey[800] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: CustomSize.xs / 2,
                    horizontal: CustomSize.xs,
                  ),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          IconsaxPlusLinear.minus,
                          color: dark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          size: 24,
                        ),
                      ),
                      const SizedBox(
                          width: CustomSize.md
                      ),
                      Text(
                        Strings.counter,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(
                          color: dark
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      const SizedBox(
                          width: CustomSize.md
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Icon(
                          IconsaxPlusLinear.add,
                          color: dark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: CustomSize.defaultSpace,
          ),
          Text(
            Strings.placeholderLong,
          )
        ],
      ),
    );
  }
}