import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

import '../../../features/personalization/model/userModel.dart';

class UserRepository extends GetxController {
  static UserRepository get to => Get.find();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _firestore.collection(Strings.collectionUser).doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (e) {
      throw FormatException();
    } catch (e) {
      throw Exception(Strings.error);
    }
  }
}