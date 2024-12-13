import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusInvoiceData.dart';
import 'package:product_catalogue/features/shop/screen/order_status/widgets/orderStatusIndicator.dart';

import '../../../../common/widgets/shop/invoiceDetail.dart';
import '../../../../common/widgets/shop/orderStatusIcon.dart';
import '../../../../common/widgets/shop/orderStatusProduct.dart';
import '../../../../common/widgets/shop/shippingAddress.dart';
import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';
import '../../controller/order/orderController.dart';

class OrderStatusPage extends StatelessWidget {
  const OrderStatusPage({
    super.key,
    required this.orderId,
  });

  final String orderId;

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.instance;
    final dark = Helper.isDarkMode(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      orderController.fetchProductsByOrderId(orderId);
      orderController.fetchOrderById(orderId);
    });

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          orderController.clearOrderById();
          orderController.clearProductsByOrder();
          orderController.clearProductsByProductId();
        }
      },
      child: Obx(
        () => orderController.isLoading.value ?
          const Center(child: CircularProgressIndicator())
          : Scaffold(
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
                    actionWidget: Visibility(
                      visible: orderController.orderById.value.status == OrderStatus.processing,
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: Get.context!,
                            builder: (_) => AlertDialog(
                              insetPadding: EdgeInsets.all(
                                  CustomSize.defaultSpace
                              ),
                              contentPadding: EdgeInsets.all(
                                  CustomSize.defaultSpace
                              ),
                              title: Row(
                                children: [
                                  Icon(
                                      IconsaxPlusLinear.tag_cross
                                  ),
                                  SizedBox(
                                      width: CustomSize.defaultSpace / 2
                                  ),
                                  Text(
                                      Strings.cancelOrder
                                  ),
                                ],
                              ),
                              content: Text(Strings.cancelOrderPrompt),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(Get.context!).pop(),
                                  child: Text(
                                      Strings.back,
                                      style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: dark ? Colors.grey[400] : Colors.grey[600],
                                      )
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: CustomSize.defaultSpace / 2,
                                      vertical: 0
                                  ),
                                  decoration: BoxDecoration(
                                    color: dark ? Colors.red[400] : Colors.red[500],
                                    borderRadius: BorderRadius.circular(
                                        CustomSize.defaultSpace
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      orderController.deleteOrderById(orderId);
                                    },
                                    child: Text(
                                        Strings.cancelOrder,
                                        style: Theme.of(Get.context!).textTheme.titleMedium!.copyWith(
                                          color: dark ? Colors.black : Colors.white,
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon (
                          IconsaxPlusLinear.tag_cross,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: orderController.orderById.value.status == OrderStatus.processing,
                    child: OrderStatusItem(
                      status: OrderStatus.processing,
                      showText: true,
                    ),
                  ),
                  Visibility(
                    visible: orderController.orderById.value.status != OrderStatus.processing,
                    child: OrderStatusIndicator(
                      status: orderController.orderById.value.status,
                    ),
                  ),
                  const SizedBox(
                      height: CustomSize.defaultSpace
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: CustomSize.defaultSpace
                    ),
                    child: ShippingAddress(
                      recipient: orderController.orderById.value.recipient,
                      address: orderController.orderById.value.address,
                      date: orderController.orderById.value.date,
                      status: orderController.orderById.value.status,
                      isEditable: orderController.orderById.value.status == OrderStatus.processing,
                    ),
                  ),
                  Column(
                    children: [
                      CustomTitle(title: Strings.orderDetail),
                      orderController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: CustomSize.defaultSpace),
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          separatorBuilder: (_, __) => SizedBox(
                            height: CustomSize.spaceBetweenItems / 2,
                          ),
                          itemCount: orderController.productsByProductId.length,
                          itemBuilder: (context, index) {
                            return OrderedProduct(
                              productId: orderController.productsByProductId[index].id,
                              image: orderController.productsByProductId[index].images.first,
                              name: orderController.productsByProductId[index].name,
                              price: orderController.productsByOrder[index].price,
                              quantity: orderController.productsByOrder[index].quantity,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: orderController.orderById.value.status == OrderStatus.processing,
                    child: Column(
                      children: [
                        CustomTitle(
                            title: Strings.payment
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: CustomSize.defaultSpace
                            ),
                            child: Container(
                              // TODO: Payment button
                            )
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      CustomTitle(
                        title: Strings.invoiceDetail,
                        indicator: orderController.orderById.value.status != OrderStatus.processing ? Strings.paid : '',
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
          bottomNavigationBar: Visibility(
            visible: orderController.orderById.value.status == OrderStatus.processing,
            child: Padding(
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
          ),
        ),
      ),
    );
  }
}