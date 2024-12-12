import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/utils/formatter/formatter.dart';

import '../../../utils/constant/enum.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/helper/helper.dart';
import '../../styles/shadow.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    super.key,
    required this.recipient,
    required this.address,
    required this.date,
    required this.status,
    required this.isEditable
  });

  final String recipient, address;
  final OrderStatus status;
  final bool isEditable;
  final DateTime date;

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
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: dark ? Colors.red[900]!.withOpacity(0.5) : Colors.red[50]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          CustomSize.sm
                      ),
                      child: Icon(
                          IconsaxPlusBold.location,
                          size: 20,
                          color: dark ? Colors.red[400] : Colors.red[500]
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: CustomSize.sm
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipient,
                          style: Theme.of(context).textTheme.titleLarge
                        ),
                        Text(
                            address,
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: dark ? Colors.grey[400] : Colors.grey[600]
                            )
                        )
                      ]
                  ),
                ],
              ),
              Row(
                children: [
                  if (!isEditable) Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            status != OrderStatus.delivered ? Strings.eta : Strings.deliveredAt,
                            style: Theme.of(context).textTheme.bodySmall
                        ),
                        Text(
                            Formatter.formatDate(date),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w500
                            )
                        )
                      ]
                  ),
                  const SizedBox(
                      width: CustomSize.sm
                  ),
                  if (isEditable) Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(
                          CustomSize.sm
                      ),
                      child: Icon(
                          IconsaxPlusLinear.edit,
                          size: 20,
                          color: dark ? Colors.grey[300] : Colors.grey[700]
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