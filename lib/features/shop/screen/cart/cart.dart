import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/screen/cart/widgets/cartProduct.dart';
import 'package:product_catalogue/features/shop/screen/confirm_order/confirmOrder.dart';
import 'package:product_catalogue/utils/helper/calculator.dart';

import '../../../../common/shimmer/commonListShimmer.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/formatter/formatter.dart';
import '../../../../utils/helper/helper.dart';
import '../../controller/cart/cartController.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
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
                final selectedCount = controller.cart
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
                        Strings.itemSelected(selectedCount),
                      ),
                    ),
                  ),
                );
              }),
              Obx(
                () => controller.isLoading.value
                    ? CommonListShimmer()
                    : ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(
                      height: CustomSize.spaceBetweenItems / 2
                  ),
                  itemCount: controller.cart.length,
                  itemBuilder: (context, index) {
                    final cartItem = controller.cart[index];
                    final product = controller.cartProducts[cartItem.productId];

                    if (product == null) {
                      return const SizedBox.shrink();
                    }

                    return CartProductItem(
                        image: product.images.first,
                        name: product.name,
                        price: product.price,
                        quantity: cartItem.quantity,
                        isChecked: cartItem.isSelected
                    );
                  },
                ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Visibility(
                visible: controller.cart.isNotEmpty,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        Strings.total,
                        style: Theme.of(context).textTheme.bodyLarge
                    ),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return CustomShimmer(
                          width: CustomSize.defaultSpace * 6,
                          height: CustomSize.defaultSpace,
                          radius: 8,
                        );
                      } else {
                        final total = Calculator.selectedWishlistPrice(
                          controller.cartProducts.values.toList(),
                          controller.cart,
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
            ),
            const SizedBox(
              height: CustomSize.defaultSpace / 2,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ConfirmOrderPage(),
                    ),
                  );
                },
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
  }
}