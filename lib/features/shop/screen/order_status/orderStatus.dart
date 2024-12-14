import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/controller/home/productController.dart';
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
import '../../../../utils/popup/loading.dart';
import '../../controller/order/orderController.dart';

class OrderStatusPage extends StatefulWidget {
  const OrderStatusPage({
    super.key,
    required this.orderId,
    this.readOnly = true,
  });

  final String orderId;
  final bool readOnly;

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final orderController = OrderController.instance;
      orderController.fetchProductsByOrderId(widget.orderId);
      orderController.fetchOrderById(widget.orderId);
    });
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductController>();
    final orderController = OrderController.instance;
    final dark = Helper.isDarkMode(context);

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          orderController.clearOrderById();
          orderController.clearProductsByOrder();
          orderController.clearProductsByProductId();
        }
      },
      child: Scaffold(
        body: Obx(
              () => orderController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: CustomSize.spaceBetweenSections,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTitle(
                      title: Strings.orderStatus,
                      hasBackButton: widget.readOnly,
                      isSection: false,
                      actionWidget: Visibility(
                        visible:
                        orderController.orderById.value.status ==
                            OrderStatus.processing,
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                backgroundColor: dark
                                    ? Colors.grey[900]
                                    : Colors.white,
                                insetPadding: EdgeInsets.all(
                                    CustomSize.defaultSpace),
                                contentPadding: EdgeInsets.all(
                                    CustomSize.defaultSpace),
                                title: Row(
                                  children: [
                                    Icon(IconsaxPlusLinear.tag_cross),
                                    SizedBox(
                                        width:
                                        CustomSize.defaultSpace / 2),
                                    Text(Strings.cancelOrder),
                                  ],
                                ),
                                content: Text(Strings.cancelOrderPrompt),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text(
                                      Strings.back,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: dark
                                            ? Colors.grey[400]
                                            : Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: CustomSize.defaultSpace /
                                            2,
                                        vertical: 0),
                                    decoration: BoxDecoration(
                                      color: dark
                                          ? Colors.red[400]
                                          : Colors.red[500],
                                      borderRadius:
                                      BorderRadius.circular(
                                          CustomSize.defaultSpace),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        orderController.deleteOrderById(
                                            widget.orderId);

                                        orderController
                                            .productsByOrder
                                            .forEach((product) {
                                          productController
                                              .updateProductStock(
                                              product.productId,
                                              -product.quantity);
                                        });

                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                        orderController.fetchOrders();

                                        Loading.successSnackBar(
                                          title: Strings.success,
                                          message: Strings.orderCancelMessage,
                                        );
                                      },
                                      child: Text(
                                        Strings.cancelOrder,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                          color: dark
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(IconsaxPlusLinear.tag_cross),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                      orderController.orderById.value.status ==
                          OrderStatus.processing,
                      child: OrderStatusItem(
                        status: OrderStatus.processing,
                        showText: true,
                      ),
                    ),
                    Visibility(
                      visible:
                      orderController.orderById.value.status !=
                          OrderStatus.processing,
                      child: OrderStatusIndicator(
                        status: orderController.orderById.value.status,
                      ),
                    ),
                    const SizedBox(height: CustomSize.defaultSpace),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomSize.defaultSpace),
                      child: ShippingAddress(
                        recipient: orderController.orderById.value.recipient,
                        address: orderController.orderById.value.address,
                        date: orderController.orderById.value.date,
                        status: orderController.orderById.value.status,
                        isEditable:
                        orderController.orderById.value.status ==
                            OrderStatus.processing,
                      ),
                    ),
                    CustomTitle(title: Strings.orderDetail),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomSize.defaultSpace),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0),
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => SizedBox(
                          height: CustomSize.spaceBetweenItems / 2,
                        ),
                        itemCount:
                        orderController.productsByProductId.length,
                        itemBuilder: (context, index) {
                          return OrderedProduct(
                            productId: orderController
                                .productsByProductId[index].id,
                            image: orderController
                                .productsByProductId[index].images.first,
                            name: orderController
                                .productsByProductId[index].name,
                            price: orderController
                                .productsByOrder[index].price,
                            quantity: orderController
                                .productsByOrder[index].quantity,
                          );
                        },
                      ),
                    ),
                    orderController.orderById.value.note.isEmpty ||
                        orderController.orderById.value.status ==
                            OrderStatus.processing
                        ? SizedBox.shrink()
                        : SizedBox(
                        height: CustomSize.spaceBetweenSections),
                    Visibility(
                      visible:
                      orderController.orderById.value.note.isNotEmpty,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: CustomSize.defaultSpace),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: dark
                                ? Colors.grey[800]
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 1,
                              color: dark
                                  ? Colors.transparent
                                  : Colors.grey[300]!,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: CustomSize.defaultSpace,
                              vertical: CustomSize.defaultSpace / 2,
                            ),
                            child: Text(
                              orderController.orderById.value.note,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                      orderController.orderById.value.status ==
                          OrderStatus.processing,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: CustomSize.defaultSpace,
                          left: CustomSize.defaultSpace,
                          right: CustomSize.defaultSpace,
                        ),
                        child: TextField(
                          controller: noteController,
                          decoration: InputDecoration(
                            labelText: Strings.note,
                            border: OutlineInputBorder(),
                          ),
                          maxLines: null,
                          minLines: 2,
                        ),
                      ),
                    ),
                    CustomTitle(
                      title: Strings.invoiceDetail,
                      indicator: orderController.orderById.value.status !=
                          OrderStatus.processing
                          ? Strings.paid
                          : '',
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: CustomSize.defaultSpace),
                      child: InvoiceDetail(tableData: invoiceData),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Visibility(
            visible: orderController.orderById.value.status == OrderStatus.processing && orderController.isLoading.value == false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: CustomSize.defaultSpace / 2,
                  horizontal: CustomSize.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    // TODO MIDTRANS LOGIC HERE

                    bool isPaymentSuccess = true ; // TODO payment logic
                    String paymentId = ''; // TODO payment response
                    String paymentMethod = ''; // TODO payment response

                    if (isPaymentSuccess) {
                      orderController.updateNote(widget.orderId, noteController.text);
                      orderController.updatePaymentId(widget.orderId, paymentId);
                      orderController.updatePaymentMethod(widget.orderId,paymentMethod);
                      orderController.updateStatus(widget.orderId, OrderStatus.packing);

                      Get.back();
                      orderController.fetchOrders();

                      Loading.successSnackBar(
                          title: Strings.paymentSuccess,
                          message: Strings.paymentSuccessMessage
                      );
                    } else {
                      Loading.errorSnackBar(
                          title: Strings.paymentFailed,
                          message: Strings.paymentFailedMessage
                      );
                    }
                  },
                  child: Text(Strings.payButton),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}