import 'package:flutter/material.dart';
import 'package:product_catalogue/common/widgets/shop/orderStatusIcon.dart';
import 'package:product_catalogue/features/shop/screen/order_status/orderStatus.dart';

import '../../../utils/constant/enum.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/formatter/formatter.dart';
import '../../../utils/helper/helper.dart';
import '../../styles/shadow.dart';

class OrderHistoryItem extends StatelessWidget {
  const OrderHistoryItem({
    super.key,
    required this.orderId,
    required this.date,
    required this.status,
    required this.totalPrice,
  });

  final String orderId, date;
  final double totalPrice;
  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => OrderStatusPage(
                    orderId: orderId
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
                    Strings.total,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    Formatter.formatCurrency(totalPrice),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: dark ? Colors.blue[400] : Colors.blue[500],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        status == OrderStatus.delivered
                            ? Strings.deliveredAt
                            : Strings.eta,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        date,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: CustomSize.sm,
                  ),
                  OrderStatusItem(
                    status: status,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}