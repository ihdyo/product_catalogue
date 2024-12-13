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

  Future<CartModel> fetchCartById(String productId) async {
    try {
      final docRef = _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(productId);
      final snapshot = await docRef.get();
      if (snapshot.exists) {
        return CartModel.fromSnapshot(snapshot);
      }
      return CartModel.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> addToCart(CartModel cart) async {
    try {
      final docRef = _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(cart.productId);
      await docRef.set(cart.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateSingleField(String productId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(productId)
          .update(data);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateIsSelected(String productId, bool isSelected) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(productId)
          .update({Strings.fieldIsSelected: isSelected});
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionCart)
          .doc(productId)
          .update({Strings.fieldQuantity: quantity});
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
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