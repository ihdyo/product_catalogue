import 'package:flutter/material.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusInvoiceData.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusProductData.dart';

import '../../../../common/widgets/shop/invoiceDetail.dart';
import '../../../../common/widgets/shop/orderStatusProduct.dart';
import '../../../../common/widgets/shop/shippingAddress.dart';
import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({
    super.key,
  });

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
                title: Strings.confirmOrder,
                hasBackButton: true,
                isSection: false,
              ),
              const SizedBox(
                  height: CustomSize.defaultSpace / 2
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
                    isEditable: true
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
                      title: Strings.payment
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSize.defaultSpace
                    ),
                    child: Container(

                    )
                  )
                ],
              ),
              Column(
                children: [
                  CustomTitle(
                    title: Strings.invoiceDetail
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: CustomSize.defaultSpace / 2,
            horizontal: CustomSize.defaultSpace
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {},
              child: Text(
                  Strings.payButton,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: dark ? Colors.black : Colors.white
                  )
              )
          ),
        ),
      ),
    );
  }
}