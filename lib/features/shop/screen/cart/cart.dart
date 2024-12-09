import 'package:flutter/material.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/shop/data/cart/cartProductData.dart';
import 'package:product_catalogue/features/shop/screen/cart/widgets/cartProduct.dart';
import 'package:product_catalogue/features/shop/screen/confirm_order/confirmOrder.dart';

import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                Visibility(
                    visible: true,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: CustomSize.defaultSpace,
                          bottom: CustomSize.defaultSpace / 2
                        ),
                        child: Text(
                            Strings.itemSelected(3)
                        ),
                      ),
                    )
                ),
                ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => SizedBox(
                      height: CustomSize.spaceBetweenItems / 2
                  ),
                  itemCount: cartProductList.length,
                  itemBuilder: (context, index) {
                    return CartProductItem(
                        image: cartProductList[index].image,
                        name: cartProductList[index].name,
                        price: cartProductList[index].price,
                        quantity: cartProductList[index].quantity,
                        isChecked: cartProductList[index].isChecked,
                        isWishlist: cartProductList[index].isWishlist
                    );
                  },
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
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const ConfirmOrderPage()
                    )
                );
              },
              child: Text(
                  Strings.checkoutButton,
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
