import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:product_catalogue/features/authentication/screen/login/login.dart';
import 'package:product_catalogue/features/authentication/screen/onboarding/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../navigation/navigationMenu.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/popup/loading.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      Get.offAll(() => const NavigationMenu());
    } else {
      deviceStorage.writeIfNull(Strings.isFirstTime, false);
      deviceStorage.read(Strings.isFirstTime) != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const OnboardingScreen());
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (e) {
      throw FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (e) {
      throw FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }


  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
        accessToken: googleAuth?.accessToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (e) {
      throw FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Loading.successSnackBar(
        title: Strings.success,
        message: Strings.verificationSent,
      );
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on FirebaseException catch (e) {
      throw FirebaseException(code: e.code, message: e.message, plugin: '');
    } on FormatException catch (e) {
      throw FormatException();
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code, message: e.message);
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      throw Exception(Strings.error);
    }
  }

}