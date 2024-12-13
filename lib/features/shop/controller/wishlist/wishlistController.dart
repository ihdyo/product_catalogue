import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/wishlist/wishlistRepository.dart';

import '../../../../data/repository/product/productRepository.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/popup/loading.dart';
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

Future<void> addProductToWishlist(String productId) async {
  try {
    isLoading.value = true;
    await wishlistRepository.addToWishlist(productId);
    final product = await productRepository.fetchProductById(productId);
    wishlist.add(product);

    Loading.customToast(message: Strings.addToWishlistMessages);
  } catch (e) {
    // Handle error
  } finally {
    isLoading.value = false;
  }
}

  void removeProductFromWishlist(String productId) {
    wishlist.removeWhere((product) => product.id == productId);
    Loading.customToast(message: Strings.removeFromWishlistMessages);
  }
}