import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/cartRepository/cartRepository.dart';
import 'package:product_catalogue/data/repository/product/productRepository.dart';
import 'package:product_catalogue/features/shop/model/cartModel.dart';
import '../../model/productModel.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final isLoading = false.obs;
  RxList<CartModel> cart = <CartModel>[].obs;
  RxMap<String, ProductModel> cartProducts = <String, ProductModel>{}.obs;
  final cartRepository = Get.put(CartRepository());
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;

      final cartItems = await  cartRepository.fetchCartItems();

      final productFetchFutures = cartItems.map((item) => productRepository.fetchProductById(item.productId));
      final fetchedProducts = await Future.wait(productFetchFutures);

      cart.assignAll(cartItems);
      cartProducts.assignAll({
        for (var product in fetchedProducts) product.id: product
      });
    } catch (e) {
      cart.clear();
      cartProducts.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(String productId, int quantity) async {
    try {
      await cartRepository.addToCart(productId, quantity);
      fetchCart();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> editCartQuantity(String productId, int quantity) async {
    try {
      await cartRepository.editCartQuantity(productId, quantity);
      fetchCart();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await cartRepository.removeFromCart(productId);
      fetchCart();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}