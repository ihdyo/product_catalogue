import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/model/orderModel.dart';
import 'package:product_catalogue/features/shop/model/orderedProductModel.dart';
import 'package:product_catalogue/features/shop/screen/cart/widgets/cartProduct.dart';
import 'package:product_catalogue/features/shop/screen/order_status/orderStatus.dart';
import 'package:product_catalogue/utils/helper/calculator.dart';
import 'package:product_catalogue/utils/helper/idGenerator.dart';

import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/images.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/constant/value.dart';
import '../../../../utils/formatter/formatter.dart';
import '../../../../utils/helper/helper.dart';
import '../../../authentication/screen/onboarding/widgets/onboardingPage.dart';
import '../../../personalization/controller/user/userController.dart';
import '../../controller/cart/cartController.dart';
import '../../controller/home/productController.dart';
import '../../controller/order/orderController.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orderController = Get.find<OrderController>();
    final productController = Get.find<ProductController>();
    final cartController = Get.find<CartController>();
    final userController = Get.find<UserController>();
    final dark = Helper.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: CustomSize.spaceBetweenSections
          ),
          child: Column(
            children: [
              CustomTitle(
                title: Strings.cart,
                isSection: false,
                hasBackButton: true,
              ),
              Obx(() {
                final selectedCount = cartController.cartProduct
                    .where((cartItem) => cartItem.isSelected)
                    .length;

                return Visibility(
                  visible: selectedCount > 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: CustomSize.defaultSpace,
                          bottom: CustomSize.defaultSpace / 2
                      ),
                      child: Text(
                        Strings.productSelected(selectedCount),
                      ),
                    ),
                  ),
                );
              }),
              Obx(
                () {
                  if (cartController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else if (cartController.cartProduct.isEmpty) {
                    return Center(
                        child: OnboardingPage(
                            image: Images.placeholderEmptyCart,
                            title: Strings.emptyCart,
                            body: Strings.emptyCartBody,
                            color: Colors.blue
                        ));
                  } else {
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => SizedBox(
                          height: CustomSize.spaceBetweenItems / 2),
                      itemCount: cartController.cartProduct.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartController.cartProduct[index];
                        final product =
                            cartController.cartProducts[cartItem.productId];

                        if (product == null) {
                          return const SizedBox.shrink();
                        }

                        return CartProductItem(
                          productId: cartItem.productId,
                          image: product.images.first,
                          name: product.name,
                          price: product.price,
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
      Obx (() {
        final selectedCount = cartController.cartProduct
            .where((cartItem) => cartItem.isSelected)
            .length;

        return Visibility(
          visible: cartController.cartProduct.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CustomSize.defaultSpace / 2,
                horizontal: CustomSize.defaultSpace
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: selectedCount > 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          Strings.total,
                          style: Theme.of(context).textTheme.bodyLarge
                      ),
                      Obx(() {
                        if (cartController.isLoading.value) {
                          return CustomShimmer(
                            width: CustomSize.defaultSpace * 6,
                            height: CustomSize.defaultSpace,
                            radius: 8,
                          );
                        } else {
                          final total = Calculator.selectedWishlistPrice(
                            cartController.cartProducts.values.toList(),
                            cartController.cartProduct,
                          );

                          return Text(
                            Formatter.formatCurrency(total),
                            style: Theme.of(context).textTheme.headlineSmall,
                          );
                        }
                      },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: CustomSize.defaultSpace / 2,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedCount > 0
                        ? () async {
                            String recipient = userController.user.value.name;
                            String address = userController.user.value.address;
                            double grandTotal = Calculator.selectedWishlistPrice(
                              cartController.cartProducts.values.toList(),
                              cartController.cartProduct,
                            ) + Values.estimatedShippingPrice;
                            String orderId = IDBuilder.orderId(recipient, address);

                            List<OrderedProductModel> selectedProducts = cartController.cartProducts.values
                                .where((product) => cartController.cartProduct.any((cartItem) =>
                            cartItem.productId == product.id && cartItem.isSelected == true))
                                .map((product) => OrderedProductModel(
                              productId: product.id,
                              price: product.price,
                              quantity: cartController.cartProduct
                                  .firstWhere((cartItem) =>
                              cartItem.productId == product.id && cartItem.isSelected == true)
                                  .quantity,
                            )).toList();

                            // TODO: Payment

                            await orderController.createOrder(
                                OrderModel(
                                    id: orderId,
                                    orderedAt: DateTime.now(),
                                    address: address,
                                    date: DateTime.now().add(Duration(days: Values.estimatedShippingDays)),
                                    recipient: recipient,
                                    shippingPrice: Values.estimatedShippingPrice,
                                    totalPrice: grandTotal,
                                    status: OrderStatus.processing,
                                    paymentMethod: 'paymentMethod',
                                    paymentId: 'paymentId',
                                    note: 'note'
                                )
                            );

                            await orderController.createProductByOrder(
                              orderId,
                              selectedProducts,
                            );

                            selectedProducts.forEach((product) async {
                              await productController.updateProductStock(product.productId, product.quantity);
                              await cartController.removeFromCart(product.productId, silent: true);
                            });

                            await orderController.fetchOrders();

                            Get.to(() => OrderStatusPage(
                                orderId: orderId,
                                readOnly: false,
                            ));
                        }
                        : null,
                    child: Text(
                      Strings.checkoutButton,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: dark ? Colors.black : Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}