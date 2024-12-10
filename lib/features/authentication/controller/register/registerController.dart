import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/authentication/authenticationRepository.dart';
import 'package:product_catalogue/features/personalization/model/userModel.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../data/repository/user/userRepository.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final name = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  void emailAndPasswordRegister() async {
    try {
      FullScreenLoading.openLoadingDialog(Strings.loading);

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      if(!registerFormKey.currentState!.validate()) {
        FullScreenLoading.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(
        email.text.trim(),
        password.text.trim(),
      );

      final newUser = UserModel(
          id: userCredential.user!.uid,
          name: name.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          address: address.text.trim()
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      Loading.successSnackBar(
          title: Strings.success,
          message: Strings.accountCreated
      );

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      FullScreenLoading.stopLoading();
      Loading.errorSnackBar(
          title: Strings.error,
          message: e.toString()
      );
    }
  }
}
