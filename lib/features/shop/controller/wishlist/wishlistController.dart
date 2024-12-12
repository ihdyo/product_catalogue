import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/wishlist/wishlistRepository.dart';

import '../../../../data/repository/product/productRepository.dart';
import '../../model/productModel.dart';

class WishlistController extends GetxController {
  static WishlistController get instance => Get.find();

  final isLoading = false.obs;
  RxList<ProductModel> wishlist = <ProductModel>[].obs;
  final wishlistRepository = Get.put(WishlistRepository());
  final productRepository = Get.put(ProductRepository());

  @override
  void onInit() {
    super.onInit();
    fetchWishlists();
  }

  Future<void> fetchWishlists() async {
    try {
      isLoading.value = true;
      final wishlistIds = await wishlistRepository.fetchWishlists();
      final fetchedProducts = <ProductModel>[];
      for (String id in wishlistIds) {
        final product = await productRepository.fetchProductById(id);
        fetchedProducts.add(product);
      }
      wishlist.assignAll(fetchedProducts);
    } catch (e) {
      wishlist.assignAll([ProductModel.empty()]);
    } finally {
      isLoading.value = false;
    }
  }

}