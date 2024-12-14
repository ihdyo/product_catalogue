import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';
import 'package:product_catalogue/utils/popup/loading.dart';
import '../../../../data/repository/product/productRepository.dart';
import '../../model/productModel.dart';

class SearchQueryController extends GetxController {
  static SearchQueryController get instance => Get.find();

  final isLoading = false.obs;
  final searchField = TextEditingController();
  RxList<ProductModel> products = <ProductModel>[].obs;
  GlobalKey<FormState> searchFormKey = GlobalKey<FormState>();

  final ProductRepository productRepository = Get.put(ProductRepository());

  void fetchProductsByPrefix(String prefix) async {
    try {
      isLoading.value = true;
      final results = await productRepository.fetchProductsByPrefix(prefix);
      if (results.isEmpty) {
        Loading.errorSnackBar(title: Strings.notFound, message: Strings.notFoundMessage);
      }
      products.value = results;
    } catch (e) {
      products.value = [];
      Loading.errorSnackBar(title: Strings.error, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearchResults() {
    products.clear();
    searchField.clear();
  }
}