import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusInvoiceData.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusProductData.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusProductData.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusProductData.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusProductData.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusProductData.dart';
import 'package:product_catalogue/features/shop/screen/order_status/widgets/orderStatusIndicator.dart';
import 'package:product_catalogue/features/shop/screen/order_status/widgets/orderStatusProduct.dart';
import 'package:product_catalogue/utils/formatter/formatter.dart';

import '../../../../common/styles/shadow.dart';
import '../../../../common/widgets/shop/invoiceDetail.dart';
import '../../../../common/widgets/shop/orderStatusIcon.dart';
import '../../../../common/widgets/shop/shippingAddress.dart';
import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/images.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: CustomSize.spaceBetweenSections,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTitle(
                title: Strings.orderStatus,
                hasBackButton: true,
                isSection: false,
              ),
              OrderStatusIndicator(
                status: OrderStatus.shipping,
              ),
              const SizedBox(
                  height: CustomSize.defaultSpace
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: CustomSize.defaultSpace
                ),
                child: ShippingAddress(
                    recipient: Strings.developer,
                    address: Strings.placeholder,
                    date: Strings.placeholder,
                    status: OrderStatus.shipping,
                    isEditable: false
                ),
              ),
              Column(
                children: [
                  CustomTitle(
                      title: Strings.orderDetail
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSize.defaultSpace
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(
                          height: CustomSize.spaceBetweenItems / 2
                      ),
                      itemCount: orderStatusProductList.length,
                      itemBuilder: (context, index) {
                        return OrderedProduct(
                          image: orderStatusProductList[index].image,
                          name: orderStatusProductList[index].name,
                          price: orderStatusProductList[index].price,
                          quantity: orderStatusProductList[index].quantity
                        );
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  CustomTitle(
                    title: Strings.invoiceDetail,
                    indicator: Strings.paid,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomSize.defaultSpace
                      ),
                      child: InvoiceDetail(
                        tableData: invoiceData,
                      )
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}