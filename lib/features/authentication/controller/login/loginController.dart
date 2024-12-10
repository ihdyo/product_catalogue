import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:product_catalogue/features/personalization/controller/user/userController.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../data/repository/authentication/authenticationRepository.dart';
import '../../../../data/repository/user/userRepository.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';
import '../../../personalization/model/userModel.dart';

class LoginController extends GetxController {

  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  final authRepository = AuthenticationRepository.instance;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> emailAndPasswordLogin() async {
    try {
      FullScreenLoading.openLoadingDialog();

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

      Get.put(UserController());

      authRepository.screenRedirect();
    } catch (e) {
      FullScreenLoading.stopLoading();
      Loading.errorSnackBar(
          title: Strings.error,
          message: e.toString()
      );
    }
  }


  Future<void> googleSignIn() async {
    try {
      FullScreenLoading.openLoadingDialog();

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        await localStorage.write(Strings.uid, userCredential.user!.uid);

        final newUser = UserModel(
            id: userCredential.user!.uid,
            name: googleUser.displayName!,
            email: googleUser.email,
            phoneNumber: '',
            address: ''
        );

        final userRepository = Get.put(UserRepository());
        await userRepository.saveUserRecord(newUser);

        Loading.successSnackBar(
            title: Strings.success,
            message: Strings.loginMessage
        );

        Get.put(UserController());

        authRepository.screenRedirect();
      } else {
        FullScreenLoading.stopLoading();
        Loading.errorSnackBar(
            title: Strings.error,
            message: Strings.googleSignInError
        );
      }
    } catch (e) {
      FullScreenLoading.stopLoading();
      Loading.errorSnackBar(
          title: Strings.error,
          message: e.toString()
      );
    }
  }

}