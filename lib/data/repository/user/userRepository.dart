import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

import '../../../features/personalization/model/userModel.dart';
import '../authentication/authenticationRepository.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final authRepository = AuthenticationRepository.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _firestore.collection(Strings.collectionUser)
          .doc(user.id)
          .set(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<UserModel> fetchUserById() async {
    try {
      final snapshot = await _firestore.collection(Strings.collectionUser)
          .doc(authRepository.authUser?.uid)
          .get();
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      }
      return UserModel.empty();
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _firestore.collection(Strings.collectionUser)
          .doc(user.id)
          .update(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> updateSingleField(Map<String, dynamic> data) async {
    try {
      await _firestore.collection(Strings.collectionUser)
          .doc(authRepository.authUser?.uid)
          .update(data);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (_) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }
}