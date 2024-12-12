import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

import '../../../features/shop/model/cartModel.dart';
import '../authentication/authenticationRepository.dart';

class CartRepository extends GetxController {
  static CartRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authRepository = AuthenticationRepository.instance;

  Future<List<CartModel>> fetchCartItems() async {
    try {
      final List<CartModel> cartItems = [];

      final snapshot = await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .get();

      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          cartItems.add(CartModel.fromSnapshot(doc));
        }
      }
      return cartItems;
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> addToCart(String productId, int quantity) async {
    try {
      final docRef = _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(productId);

      await docRef.set({Strings.fieldQuantity: quantity});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> editCartQuantity(String productId, int quantity) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(productId)
          .update({Strings.fieldQuantity: quantity});
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeFromCart(String productId) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(productId)
          .delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}