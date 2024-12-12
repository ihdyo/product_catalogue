import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

import '../../../features/personalization/model/userModel.dart';
import '../authentication/authenticationRepository.dart';

class WishlistRepository extends GetxController {
  static WishlistRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authRepository = AuthenticationRepository.instance;

  Future<List<String>> fetchWishlists() async {
    try {
      final wishlistProductIds = <String>[];

      final snapshot = await _firestore.collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionWishlist)
          .get();
      if (snapshot.docs.isNotEmpty) {
        for (var doc in snapshot.docs) {
          wishlistProductIds.add(doc.id);
        }
      }
      return wishlistProductIds;
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> addToWishlist(String productId) async {
    try {
      await _firestore.collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionWishlist)
          .doc(productId)
          .set({});
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    try {
      await _firestore.collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionWishlist)
          .doc(productId)
          .delete();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } catch (e) {
      throw Exception(Strings.error);
    }
  }
}