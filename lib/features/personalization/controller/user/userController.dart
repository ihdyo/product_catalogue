import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/features/personalization/model/userModel.dart';

import '../../../../data/repository/user/userRepository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserById();
      this.user(user);
      profileLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Future<void> saveUserRecord(UserCredential? userCredential) async {
  //   try {
  //     if (userCredential != null) {
  //       final user = UserModel(
  //         id: userCredential.user!.uid,
  //         name: userCredential.user!.displayName ?? '',
  //         email: userCredential.user!.email ?? '',
  //         phoneNumber: userCredential.user!.phoneNumber ?? '',
  //         address: userCredential.user!.address ?? '',
  //       );
  //
  //       await userRepository.saveUserRecord(user);
  //     }
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }
}
