import 'package:get/get.dart';
import 'package:product_catalogue/features/shop/controller/cart/cartController.dart';
import 'package:product_catalogue/features/shop/controller/home/productController.dart';
import 'package:product_catalogue/features/shop/controller/order/orderController.dart';
import 'package:product_catalogue/features/shop/controller/temporary/temporaryController.dart';

import '../utils/helper/networkManager.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());

    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<TemporaryController>(() => TemporaryController());
  }
}
