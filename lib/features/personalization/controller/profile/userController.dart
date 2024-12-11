import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/features/personalization/model/userModel.dart';

import '../../../../data/repository/user/userRepository.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final isLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  Future<void> fetchUser() async {
    try {
      isLoading.value = true;
      final user = await userRepository.fetchUserById();
      this.user(user);
      isLoading.value = false;
    } catch (e) {
      user(UserModel.empty());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> saveUserRecord(UserCredential? userCredential) async {
    try {
      if (userCredential != null) {
        final userDoc = await userRepository.fetchUserById();

        if (userDoc.id.isEmpty) {
          final user = UserModel(
            id: userCredential.user!.uid,
            name: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            address: '',
          );

          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
