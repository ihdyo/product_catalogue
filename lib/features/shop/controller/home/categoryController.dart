import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/category/categoryRepository.dart';

import '../../model/categoryModel.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  Rx<CategoryModel> categoryById = CategoryModel.empty().obs;
  final categoryRepository = Get.put(CategoryRepository());

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading.value = true;
      final fetchedCategories = await categoryRepository.fetchCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      categories.assignAll([CategoryModel.empty()]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCategoryById(String id) async {
    try {
      isLoading.value = true;
      final fetchedCategory = await categoryRepository.fetchCategoryById(id);
      categoryById.value = fetchedCategory;
    } catch (e) {
      categoryById.value = CategoryModel.empty();
    } finally {
      isLoading.value = false;
    }
  }
}