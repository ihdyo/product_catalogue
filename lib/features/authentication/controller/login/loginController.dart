import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../data/repository/authentication/authenticationRepository.dart';
import '../../../../data/repository/user/userRepository.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';

class LoginController extends GetxController {

  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordLogin() async {
    try {
      FullScreenLoading.openLoadingDialog(Strings.loading);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      if(!loginFormKey.currentState!.validate()) {
        FullScreenLoading.stopLoading();
        return;
      }

      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(
          email.text.trim(),
          password.text.trim()
      );

      await localStorage.write(Strings.uid, userCredential.user!.uid);

      Loading.successSnackBar(
          title: Strings.success,
          message: Strings.loginMessage
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