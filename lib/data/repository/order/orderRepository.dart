import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/features/shop/model/orderModel.dart';
import 'package:product_catalogue/features/shop/model/orderedProductModel.dart';
import 'package:product_catalogue/features/shop/model/orderedProductModel.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

import '../../../features/shop/model/productModel.dart';
import '../authentication/authenticationRepository.dart';

class OrderRepository extends GetxController {
  static OrderRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authRepository = AuthenticationRepository.instance;

  Future<List<OrderModel>> fetchOrders() async {
    try {
      final userId = authRepository.authUser?.uid;

      final snapshot = await _firestore
          .collection(Strings.collectionUsers)
          .doc(userId)
          .collection(Strings.collectionOrder)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          return OrderModel.fromSnapshot(doc);
        }).toList();
      }
      return List.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }


  Future<OrderModel> fetchOrderById(String orderId) async {
    try {
      final snapshot = await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionOrder)
          .doc(orderId)
          .get();

      if (snapshot.exists) {
        return OrderModel.fromSnapshot(snapshot);
      }
      return OrderModel.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<List<OrderedProductModel>> fetchProductsByOrderId(String orderId) async {
    try {
      final snapshot = await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionOrder)
          .doc(orderId)
          .collection(Strings.collectionProducts)
          .get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) => OrderedProductModel.fromSnapshot(doc)).toList();
      }
      return List.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionOrder)
          .doc(order.id)
          .update(order.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateSingleField(String orderId, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionOrder)
          .doc(orderId)
          .update(data);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> removeOrder(String orderId) async {
    try {
      await _firestore
          .collection(Strings.collectionUsers)
          .doc(authRepository.authUser?.uid)
          .collection(Strings.collectionOrder)
          .doc(orderId)
          .delete();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: e.plugin);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

}