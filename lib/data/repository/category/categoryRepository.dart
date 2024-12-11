import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/features/shop/model/categoryModel.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final querySnapshot = await _firestore.collection(Strings.collectionCategories).get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) => CategoryModel.fromSnapshot(doc)).toList();
      }
      return List.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }
}