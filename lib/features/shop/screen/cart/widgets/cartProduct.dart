import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../common/styles/shadow.dart';
import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/formatter/formatter.dart';
import '../../../../../utils/helper/helper.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    super.key,
    this.isChecked = false,
    this.isWishlist = false,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity
  });

  final bool isChecked, isWishlist;
  final String image, name;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(
        left:  CustomSize.defaultSpace / 2,
        right: CustomSize.defaultSpace,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (_) {},
          ),
          Expanded(
            child: IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  color: dark ? Colors.grey[900] : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [ShadowStyle().shadowSmall()],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: CustomSize.sm,
                    horizontal: CustomSize.sm,
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: CustomSize.imageCartSize,
                        height: CustomSize.imageCartSize,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                Images.placeholder,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                          width: CustomSize.defaultSpace / 2
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: CustomSize.xs),
                                Text(
                                  Formatter.formatCurrency(price),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: Icon(
                                    isWishlist ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
                                    color: dark ? Colors.red[400] : Colors.red[500],
                                  ),
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
                                          onTap: quantity <= 1 ? null : () {},
                                          child: Icon(
                                            quantity == 1
                                                ? IconsaxPlusLinear.trash
                                                : IconsaxPlusLinear.minus,
                                            color: dark
                                                ? Colors.grey[400]
                                                : Colors.grey[600],
                                          ),
                                        ),
                                        const SizedBox(
                                            width: CustomSize.md
                                        ),
                                        Text(
                                          quantity.toString(),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}