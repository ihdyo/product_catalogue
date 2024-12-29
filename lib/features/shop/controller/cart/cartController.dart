import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/cart/cartRepository.dart';
import 'package:product_catalogue/data/repository/product/productRepository.dart';
import 'package:product_catalogue/features/shop/model/cartModel.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/popup/loading.dart';
import '../../model/productModel.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  final isLoading = false.obs;
  RxList<CartModel> cartProduct = <CartModel>[].obs;
  RxMap<String, ProductModel> cartProducts = <String, ProductModel>{}.obs;
  final cartRepository = Get.put(CartRepository());
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    super.onInit();
    fetchCarts();
  }

  Future<void> fetchCarts() async {
    try {
      isLoading.value = true;

      final cartItems = await  cartRepository.fetchCartItems();

      final productFetchFutures = cartItems.map((item) => productRepository.fetchProductById(item.productId));
      final fetchedProducts = await Future.wait(productFetchFutures);

      cartProduct.assignAll(cartItems);
      cartProducts.assignAll({
        for (var product in fetchedProducts) product.id: product
      });
    } catch (e) {
      cartProduct.clear();
      cartProducts.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<CartModel?> fetchCartById(String productId) async {
    try {
      isLoading.value = true;

      final cartItem = await cartRepository.fetchCartById(productId);

      return CartModel(
        productId: cartItem.productId,
        quantity: cartItem.quantity,
        isSelected: cartItem.isSelected,
      );
        } catch (e) {
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> modifyCart(String productId,CartModel cart) async {
    try {
      final existingCartItem = cartProduct.firstWhereOrNull((item) => item.productId == cart.productId);

      if (existingCartItem != null) {
        final updatedQuantity = existingCartItem.quantity + cart.quantity;

        if (updatedQuantity <= 0) {
          await cartRepository.removeFromCart(cart.productId);

          Loading.warningSnackBar(title:Strings.success, message: Strings.removeFromCartMessage);
          fetchCarts();
        } else {
          Map<String, dynamic> cart = {Strings.fieldQuantity: updatedQuantity};
          await cartRepository.updateSingleField(productId, cart);

          Loading.successSnackBar(title:Strings.success, message: Strings.addToCartMessage);
          fetchCarts();
        }
      } else {
        await cartRepository.addToCart(cart);

        Loading.successSnackBar(title:Strings.success, message: Strings.addToCartMessage);
        fetchCarts();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateIsSelected(String productId, bool isSelected) async {
    try {
      await cartRepository.updateIsSelected(productId, isSelected);

      fetchCarts();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    try {
      await cartRepository.updateQuantity(productId, quantity);

      fetchCarts();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeFromCart(String productId, {bool silent = false}) async {
    try {
      await cartRepository.removeFromCart(productId);

      if (!silent) Loading.warningSnackBar(title:Strings.success, message: Strings.removeFromCartMessage);
      fetchCarts();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}