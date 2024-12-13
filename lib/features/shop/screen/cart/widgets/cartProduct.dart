import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/data/order_status/orderStatusInvoiceData.dart';

import '../../../../../common/styles/shadow.dart';
import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/formatter/formatter.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../controller/cart/cartController.dart';
import '../../../controller/home/productController.dart';
import '../../../controller/wishlist/wishlistController.dart';
import '../../../model/cartModel.dart';
import '../../product_detail/productDetail.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    super.key,
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
  });

  final String productId, image, name;
  final double price;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final productController = ProductController.instance;
    final wishlistController = WishlistController.instance;
    final dark = Helper.isDarkMode(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      wishlistController.fetchWishlists();
    });

    return Obx(() {
      bool isWishlist = productController.isProductInWishlist(productId);
      int quantity = cartController.cartProduct
          .firstWhere((element) => element.productId == productId)
          .quantity;
      bool isChecked = cartController.cartProduct
          .firstWhere((element) => element.productId == productId)
          .isSelected;

      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                id: productId,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: CustomSize.defaultSpace / 2,
            right: CustomSize.defaultSpace,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (_) {
                  cartController.updateIsSelected(productId, !isChecked);
                },
              ),
              Expanded(
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: dark ? Colors.grey[900] : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [ShadowStyle().shadowSmall()],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: CustomSize.sm,
                        horizontal: CustomSize.sm,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: CustomSize.imageCartSize,
                            height: CustomSize.imageCartSize,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    Images.placeholder,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: CustomSize.defaultSpace / 2),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style:
                                          Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: CustomSize.xs),
                                    Text(
                                      Formatter.formatCurrency(price),
                                      style:
                                          Theme.of(context).textTheme.titleLarge,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        isWishlist
                                            ? productController
                                                .removeProductFromWishlist(
                                                    productId)
                                            : productController
                                                .addProductToWishlist(productId);
                                      },
                                      child: Icon(
                                        isWishlist
                                            ? IconsaxPlusBold.heart
                                            : IconsaxPlusLinear.heart,
                                        color: dark
                                            ? Colors.red[400]
                                            : Colors.red[500],
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: dark
                                            ? Colors.grey[800]
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: CustomSize.xs,
                                          horizontal: CustomSize.xs,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: quantity <= 1
                                                  ? () {
                                                showDialog(
                                                  context: context,
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
                                                            IconsaxPlusLinear.trash
                                                        ),
                                                        SizedBox(
                                                            width: CustomSize.defaultSpace / 2
                                                        ),
                                                        Text(
                                                            Strings.removeFromCart
                                                        ),
                                                      ],
                                                    ),
                                                    content: Text(Strings.removeFromCartPrompt),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () => Navigator.of(Get.context!).pop(),
                                                        child: Text(
                                                            Strings.cancel,
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
                                                          color: dark ? Colors.orange[400] : Colors.orange[500],
                                                          borderRadius: BorderRadius.circular(
                                                              CustomSize.defaultSpace
                                                          ),
                                                        ),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            cartController.removeFromCart(productId);
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text(
                                                              Strings.remove,
                                                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                                                color: dark ? Colors.black : Colors.white,
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                                  : () {
                                                cartController.updateQuantity(productId, quantity - 1);
                                              },
                                              child: Icon(
                                                quantity == 1
                                                    ? IconsaxPlusLinear.trash
                                                    : IconsaxPlusLinear.minus,
                                                color: dark
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600],
                                              ),
                                            ),
                                            const SizedBox(width: CustomSize.md),
                                            Text(
                                              quantity.toString(),
                                              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                                                    color: dark ? Colors.white : Colors.black,
                                              ),
                                            ),
                                            const SizedBox(width: CustomSize.md),
                                            GestureDetector(
                                              onTap: () {
                                                cartController.updateQuantity(productId, quantity + 1);
                                              },
                                              child: Icon(
                                                IconsaxPlusLinear.add,
                                                color: dark
                                                    ? Colors.grey[400]
                                                    : Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}