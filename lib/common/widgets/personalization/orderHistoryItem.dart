import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../utils/constant/enum.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/formatter/formatter.dart';
import '../../../utils/helper/helper.dart';
import '../../styles/shadow.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({
    super.key,
    required this.date,
    required this.status,
    required this.itemCount,
    required this.totalPrice
  });

  final String date;
  final OrderStatus status;
  final double totalPrice;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Container(
      decoration: BoxDecoration(
        color: dark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
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
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemCount == 1 ? '$itemCount item' : '$itemCount items'
                    ),
                    Text(
                      Formatter.formatCurrency(totalPrice),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: dark ? Colors.blue[400] : Colors.blue[500]
                      ),
                    )
                  ]
              ),
              Row(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            status != OrderStatus.delivered ? Strings.eta : Strings.deliveredAt,
                            style: Theme.of(context).textTheme.bodySmall
                        ),
                        Text(
                            date,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500
                            )
                        )
                      ]
                  ),
                  const SizedBox(
                      width: CustomSize.sm
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: status == OrderStatus.packing
                            ? (dark ? Colors.orange[900]!.withOpacity(0.5) : Colors.orange[50])
                            : status == OrderStatus.shipping
                            ? (dark ? Colors.green[900]!.withOpacity(0.5) : Colors.green[50])
                            : (dark ? Colors.lightBlue[900]!.withOpacity(0.5) : Colors.lightBlue[50])
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          CustomSize.sm
                      ),
                      child: Icon(
                          status == OrderStatus.packing
                              ? IconsaxPlusBold.archive_2
                              : status == OrderStatus.shipping
                              ? IconsaxPlusBold.truck
                              : IconsaxPlusBold.direct_right,
                          size: 20,
                          color: status == OrderStatus.packing
                              ? (dark ? Colors.orange[400] : Colors.orange[500])
                              : status == OrderStatus.shipping
                              ? (dark ? Colors.green[400] : Colors.green[500])
                              : (dark ? Colors.lightBlue[400] : Colors.lightBlue[500])
                      ),
                    ),
                  ),
                ],
              )
            ]
        ),
      ),
    );
  }
}