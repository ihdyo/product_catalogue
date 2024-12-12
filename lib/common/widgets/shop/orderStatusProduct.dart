import 'package:flutter/material.dart';
import 'package:product_catalogue/features/shop/screen/product_detail/productDetail.dart';

import '../../../../../common/styles/shadow.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/formatter/formatter.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../utils/constant/images.dart';

class OrderedProduct extends StatelessWidget {
  const OrderedProduct({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required String productId,
  }) : _productId = productId;

  final String _productId;
  final String image, name;
  final double price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(
                    id: _productId
                )
            )
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: dark ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            ShadowStyle().shadowSmall()
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: CustomSize.sm,
              horizontal: CustomSize.sm
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: CustomSize.imageOrderSize,
                      height: CustomSize.imageOrderSize,
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
                        width: CustomSize.md
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              name,
                              style: Theme.of(context).textTheme.bodyMedium
                          ),
                          const SizedBox(
                              height: CustomSize.xs
                          ),
                          Text(
                              Formatter.formatCurrency(price),
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: dark ? Colors.blue[400] : Colors.blue[500]
                              )
                          )
                        ]
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: dark ? Colors.blue[900]!.withOpacity(0.5) : Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: CustomSize.xs / 2,
                      horizontal: CustomSize.sm,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'x$quantity',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: dark ? Colors.blue[400] : Colors.blue[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}