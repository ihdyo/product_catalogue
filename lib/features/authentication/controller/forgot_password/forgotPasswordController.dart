import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../data/repository/authentication/authenticationRepository.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';
import '../../screen/login/login.dart';

class ForgotPasswordController extends GetxController {

  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  sendVerification() async {
    try {
      FullScreenLoading.openLoadingDialog(Strings.loading);

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      if(!forgotPasswordFormKey.currentState!.validate()) {
        FullScreenLoading.stopLoading();
        return;
      }

      await AuthenticationRepository.instance.forgotPassword(email.text.trim());

      Get.offAll(() => const LoginScreen());
    } catch (e) {
      FullScreenLoading.stopLoading();
      Loading.errorSnackBar(
          title: Strings.error,
          message: e.toString()
      );
    }
  }
}