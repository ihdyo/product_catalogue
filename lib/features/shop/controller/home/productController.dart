import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/product/productRepository.dart';

import '../../model/productModel.dart';
import '../wishlist/wishlistController.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ProductModel> products = <ProductModel>[].obs;
  RxList<ProductModel> recentProducts = <ProductModel>[].obs;
  Rx<ProductModel> productById = ProductModel.empty().obs;
  final RxList<ProductModel> productsByCategory = <ProductModel>[].obs;
  final productRepository = Get.put(ProductRepository());
  final wishlistController = Get.put(WishlistController());

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      final fetchedProducts = await productRepository.fetchProducts();
      products.assignAll(fetchedProducts);
    } catch (e) {
      products.assignAll([ProductModel.empty()]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsByIds(List<String> ids) async {
    try {
      isLoading.value = true;
      List<ProductModel> fetchedProducts = [];
      ids = ids.where((id) => id.isNotEmpty).toList();

      for (String id in ids) {
        final product = await productRepository.fetchProductById(id);
        fetchedProducts.add(product);
      }

      recentProducts.assignAll(fetchedProducts);
    } catch (e) {
      recentProducts.assignAll([ProductModel.empty()]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductById(String id) async {
    try {
      isLoading.value = true;
      final fetchedProduct = await productRepository.fetchProductById(id);
      productById.value = fetchedProduct;
    } catch (e) {
      productById.value = ProductModel.empty();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsByCategory(String categoryId) async {
    try {
      isLoading.value = true;
      final fetchedProducts = await productRepository.fetchProductsByCategory(categoryId);
      productsByCategory.value = fetchedProducts;
    } catch (e) {
      productsByCategory.value = [ProductModel.empty()];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await productRepository.updateProduct(product);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  bool isProductInWishlist(String productId) {
    return wishlistController.wishlist.any((product) => product.id == productId);
  }

  void addProductToWishlist(String productId) {
    wishlistController.addProductToWishlist(productId);
  }

  void removeProductFromWishlist(String productId) {
    wishlistController.removeProductFromWishlist(productId);
  }

  void clearProductById() {
    productById.value = ProductModel.empty();
  }

  void clearProductsByCategory() {
    productsByCategory.value = [];
  }
}