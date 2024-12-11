import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

import '../../../features/shop/model/productModel.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final snapshot = await _firestore.collection(Strings.collectionProducts).get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      }
      return List.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<ProductModel> fetchProductById(String id) async {
    try {
      final snapshot = await _firestore.collection(Strings.collectionProducts).doc(id).get();

      if (snapshot.exists) {
        return ProductModel.fromSnapshot(snapshot);
      }
      return ProductModel.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestore.collection(Strings.collectionProducts)
          .doc(product.id)
          .update(product.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateSingleField(String id, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(Strings.collectionProducts)
          .doc(id)
          .update(data);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }
}