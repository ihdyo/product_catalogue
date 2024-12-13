import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/controller/home/productController.dart';
import 'package:product_catalogue/features/shop/controller/temporary/temporaryController.dart';
import 'package:product_catalogue/utils/popup/loading.dart';

import '../../../features/shop/controller/cart/cartController.dart';
import '../../../features/shop/model/cartModel.dart';
import '../../../navigation/controller/navigationController.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/helper/helper.dart';

class AddToCartFAB extends StatelessWidget {
  const AddToCartFAB({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final temporaryController = TemporaryController.instance;
    final cartController = CartController.instance;
    final controller = Get.put(NavigationController());
    final dark = Helper.isDarkMode(context);

    return Obx(() {
      final isAvailable = productController.productById.value.stock >= temporaryController.getProductQuantityById(productController.productById.value.id);
      final count = temporaryController.collectedProducts.fold<int>(0, (previousValue, element) => previousValue + element.quantity,);
      final showFAB = controller.currentIndex.value != 2 && temporaryController.collectedProducts.isNotEmpty;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          Visibility(
            visible: showFAB,
            child: FloatingActionButton(
              onPressed: !isAvailable ? null
                  : () => {
                for (final element in temporaryController.collectedProducts.toList()) {
                  cartController.modifyCart(
                    element.productId,
                    CartModel(
                      productId: element.productId,
                      quantity: element.quantity,
                      isSelected: false,
                    ),
                  )
                },
                print('GEDEBUG: ${temporaryController.collectedProducts.toList()}'),
                temporaryController.clearProducts(),
              },
              backgroundColor: !isAvailable ? (dark ? Colors.grey[400] : Colors.grey[500]) : (dark ? Colors.blue[400] : Colors.blue[500]),
              tooltip: Strings.addToCart,
              child: Icon(
                !isAvailable ? IconsaxPlusLinear.warning_2 : IconsaxPlusLinear.shopping_bag,
                color: dark ? Colors.black : Colors.white,
              ),
            ),
          ),
          Visibility(
            visible: isAvailable && showFAB,
            child: Positioned(
              left: -4,
              top: -4,
              child: Obx(
                () => temporaryController.collectedProducts.isNotEmpty
                    ? Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: CustomSize.xs,
                    vertical: CustomSize.xs / 2,
                  ),
                  decoration: BoxDecoration(
                    color: dark ? Colors.red[400] : Colors.red[500],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: CustomSize.md,
                    minHeight: CustomSize.md,
                  ),
                  child: Text(
                    count.toString(),
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      );
    });
  }
}