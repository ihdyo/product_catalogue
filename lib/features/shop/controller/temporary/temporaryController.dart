import 'package:get/get.dart';
import 'package:product_catalogue/features/shop/model/orderedProductModel.dart';
import '../home/productController.dart';

class TemporaryController extends GetxController {
  static TemporaryController get instance => Get.find();

  final isLoading = false.obs;
  RxList<OrderedProductModel> collectedProducts = <OrderedProductModel>[].obs;
  final productController = ProductController.instance;

  void fetchProducts() {
    isLoading.value = true;
    collectedProducts.clear();
    isLoading.value = false;
  }

  void addProduct(String productId, int quantity) {
    final actualProduct = productController.products.firstWhereOrNull(
          (product) => product.id == productId,
    );

    if (actualProduct == null) return;

    final existingProduct = collectedProducts.firstWhereOrNull(
          (product) => product.productId == productId,
    );

    if (existingProduct == null) {
      collectedProducts.add(
        OrderedProductModel(
          productId: productId,
          price: actualProduct.price,
          quantity: quantity,
        ),
      );
    }
  }

  void removeProduct(String productId) {
    collectedProducts.removeWhere((product) => product.productId == productId);
  }

  void editProduct(String productId, int newQuantity) {
    final index = collectedProducts.indexWhere(
          (product) => product.productId == productId,
    );

    final actualProduct = productController.products.firstWhereOrNull(
          (product) => product.id == productId,
    );

    if (actualProduct == null) return;

    final actualPrice = actualProduct.price;

    if (newQuantity <= 0) {
      if (index != -1) {
        collectedProducts.removeAt(index);
      }
    } else {
      if (index == -1) {
        collectedProducts.add(
          OrderedProductModel(
            productId: productId,
            price: actualPrice,
            quantity: newQuantity,
          ),
        );
      } else {
        final existingProduct = collectedProducts[index];
        final quantityDifference = newQuantity - existingProduct.quantity;
        final updatedPrice = existingProduct.price + (actualPrice * quantityDifference);

        collectedProducts[index] = OrderedProductModel(
          productId: existingProduct.productId,
          price: updatedPrice,
          quantity: newQuantity,
        );
      }
    }
  }

  // Clears all products in the collection
  void clearProducts() {
    collectedProducts.clear();
  }

  // Fetches the product and its quantity by productId
  int getProductQuantityById(String id) {
    final product = collectedProducts.firstWhere(
          (p) => p.productId == id,
      orElse: () => OrderedProductModel.empty(),
    );

    return product.quantity;
  }
}