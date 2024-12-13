import 'package:get/get.dart';
import 'package:product_catalogue/features/shop/controller/cart/cartController.dart';
import 'package:product_catalogue/features/shop/controller/order/orderController.dart';

import '../utils/helper/networkManager.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());

    Get.put(OrderController());
    Get.put(CartController());
  }
}
