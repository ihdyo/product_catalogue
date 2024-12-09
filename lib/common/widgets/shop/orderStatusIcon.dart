import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../utils/constant/enum.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/helper/helper.dart';

class OrderStatusItem extends StatelessWidget {
  const OrderStatusItem({
    super.key,
    required this.status,
    this.showText = false,
    this.isActive = true
  });

  final OrderStatus status;
  final bool showText, isActive;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? (status == OrderStatus.packing
                  ? (dark ? Colors.orange[900]!.withOpacity(0.5) : Colors.orange[50])
                  : status == OrderStatus.shipping
                  ? (dark ? Colors.green[900]!.withOpacity(0.5) : Colors.green[50])
                  : (dark ? Colors.lightBlue[900]!.withOpacity(0.5) : Colors.lightBlue[50]))
                  : Colors.transparent
          ),
          child: Padding(
            padding: const EdgeInsets.all(
                CustomSize.sm
            ),
            child: Icon(
                status == OrderStatus.packing
                    ? (isActive ? IconsaxPlusBold.archive_2 : IconsaxPlusLinear.archive_2)
                    : status == OrderStatus.shipping
                    ? (isActive ? IconsaxPlusBold.truck : IconsaxPlusLinear.truck)
                    : (isActive ? IconsaxPlusBold.direct_right : IconsaxPlusLinear.direct_right),
                size: 20,
                color: !isActive
                    ? (dark ? Colors.grey[300] : Colors.grey[700])
                    : status == OrderStatus.packing
                    ? (dark ? Colors.orange[400] : Colors.orange[500])
                    : status == OrderStatus.shipping
                    ? (dark ? Colors.green[400] : Colors.green[500])
                    : (dark ? Colors.lightBlue[400] : Colors.lightBlue[500])
            ),
          ),
        ),
        if (showText) Column(
          children: [
            const SizedBox(
                height: CustomSize.xs
            ),
            Text(
                status == OrderStatus.packing
                    ? Strings.packing
                    : status == OrderStatus.shipping
                    ? Strings.shipping
                    : Strings.delivered,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                    color: !isActive
                        ? (dark ? Colors.grey[400] : Colors.grey[600])
                        : status == OrderStatus.packing
                        ? (dark ? Colors.orange[400] : Colors.orange[500])
                        : status == OrderStatus.shipping
                        ? (dark ? Colors.green[400] : Colors.green[500])
                        : (dark ? Colors.lightBlue[400] : Colors.lightBlue[500])
                )
            ),
          ],
        )
      ],
    );
  }
}
