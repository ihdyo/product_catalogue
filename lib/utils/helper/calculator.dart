import '../../features/shop/model/cartModel.dart';
import '../../features/shop/model/productModel.dart';

class Calculator {
  static double totalPrice(
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
}
