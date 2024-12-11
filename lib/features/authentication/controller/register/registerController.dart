import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/authentication/authenticationRepository.dart';
import 'package:product_catalogue/features/personalization/model/userModel.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../data/repository/user/userRepository.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';
import '../../../personalization/controller/user/userController.dart';

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
  final userController = Get.put(UserController());


  void emailAndPasswordRegister() async {
    try {
      FullScreenLoading.openLoadingDialog();

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
          phoneNumber: '',
          address: ''
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      await userController.fetchUser();

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
