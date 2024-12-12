import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../utils/constant/enum.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/helper/helper.dart';

class OrderStatusItem extends StatelessWidget {
  const OrderStatusItem({
    super.key,
    required this.status,
    this.showText = false,
    this.isActive = true,
  });

  final OrderStatus status;
  final bool showText, isActive;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    Color getColor(OrderStatus status, bool isActive) {
      if (!isActive) return dark ? Colors.grey[300]! : Colors.grey[700]!;
      switch (status) {
        case OrderStatus.packing:
          return dark ? Colors.orange[400]! : Colors.orange[500]!;
        case OrderStatus.shipping:
          return dark ? Colors.green[400]! : Colors.green[500]!;
        case OrderStatus.delivered:
          return dark ? Colors.lightBlue[400]! : Colors.lightBlue[500]!;
        default:
          return dark ? Colors.grey[300]! : Colors.grey[700]!;
      }
    }

    Color getBackgroundColor(OrderStatus status, bool isActive) {
      if (!isActive) return Colors.transparent;
      switch (status) {
        case OrderStatus.packing:
          return dark
              ? Colors.orange[900]!.withOpacity(0.5)
              : Colors.orange[50]!;
        case OrderStatus.shipping:
          return dark
              ? Colors.green[900]!.withOpacity(0.5)
              : Colors.green[50]!;
        case OrderStatus.delivered:
          return dark
              ? Colors.lightBlue[900]!.withOpacity(0.5)
              : Colors.lightBlue[50]!;
        default:
          return Colors.transparent;
      }
    }

    IconData getIcon(OrderStatus status, bool isActive) {
      switch (status) {
        case OrderStatus.packing:
          return isActive ? IconsaxPlusBold.archive_2 : IconsaxPlusLinear.archive_2;
        case OrderStatus.shipping:
          return isActive ? IconsaxPlusBold.truck : IconsaxPlusLinear.truck;
        case OrderStatus.delivered:
          return isActive ? IconsaxPlusBold.direct_right : IconsaxPlusLinear.direct_right;
        default:
          return IconsaxPlusLinear.timer_1;
      }
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: getBackgroundColor(status, isActive),
          ),
          child: Padding(
            padding: const EdgeInsets.all(CustomSize.sm),
            child: Icon(
              getIcon(status, isActive),
              size: 20,
              color: getColor(status, isActive),
            ),
          ),
        ),
        if (showText)
          Column(
            children: [
              const SizedBox(height: CustomSize.xs),
              Text(
                status.name,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                  color: getColor(status, isActive),
                ),
              ),
            ],
          ),
      ],
    );
  }
}