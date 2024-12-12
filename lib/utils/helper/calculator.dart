import 'package:product_catalogue/features/shop/model/orderedProductModel.dart';

import '../../features/shop/model/cartModel.dart';
import '../../features/shop/model/orderModel.dart';
import '../../features/shop/model/productModel.dart';

class Calculator {
  static double selectedWishlistPrice(
      List<ProductModel> products, List<CartModel> cart) {
    double total = 0;

    for (int i = 0; i < products.length; i++) {
      final product = products[i];
      final cartItem = cart[i];

      if (cartItem.isSelected) {
        total += product.price * cartItem.quantity;
      }
    }

    return total;
  }

  static double totalItemPrice(
      List<OrderedProductModel> productsByOrder, List<OrderModel> orders) {
    double total = 0.0;

    for (var product in productsByOrder) {
      total += product.price * product.quantity;
    }
    return total;
  }
}
