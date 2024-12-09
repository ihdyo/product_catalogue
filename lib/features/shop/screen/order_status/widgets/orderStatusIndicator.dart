import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/shop/orderStatusIcon.dart';
import '../../../../../utils/constant/enum.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../data/order_status/orderStatusData.dart';

class OrderStatusIndicator extends StatelessWidget {
  const OrderStatusIndicator({
    super.key,
    required this.status,
  });

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CustomSize.defaultSpace,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: CustomSize.defaultSpace / 2
        ),
        child: Center(
          child: SizedBox(
            height: CustomSize.orderStatusHeight,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(
                  horizontal: CustomSize.defaultSpace / 2
              ),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CustomSize.defaultSpace / 2
                  ),
                  child: SizedBox(
                      width: CustomSize.defaultSpace * 2,
                      child: DottedDashedLine(
                        height: 0,
                        width: 100,
                        axis: Axis.horizontal,
                        dashColor: dark ? Colors.grey[600]! : Colors.grey[400]!,
                      )
                  ),
                ),
              ),
              itemCount: orderStatusList.length,
              itemBuilder: (context, index) {
                final isActive = orderStatusList[index].status == status;

                return OrderStatusItem(
                  status: orderStatusList[index].status,
                  showText: true,
                  isActive: isActive,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}