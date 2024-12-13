import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../data/repository/user/userRepository.dart';
import '../../../navigation/screen/navigationMenu.dart';
import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';
import '../user/userController.dart';

class ChangePhoneController extends GetxController {
  static ChangePhoneController get instance => Get.find();

  final phone = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> changePhoneFormKey = GlobalKey<FormState>();

  Future<void> changePhone() async {
    try {
      FullScreenLoading.openLoadingDialog();
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      if(!changePhoneFormKey.currentState!.validate()) {
        FullScreenLoading.stopLoading();
        return;
      }

      Map<String, dynamic> data = {Strings.fieldPhoneNumber: phone.text.trim()};
      await userRepository.updateSingleField(data);

      userController.user.value.phoneNumber = phone.text.trim();

      Loading.successSnackBar(
          title: Strings.success,
          message: Strings.changePhoneMessages
      );

      Get.offAll(() => const NavigationMenu(), arguments: 2);
    } catch(e) {
      FullScreenLoading.stopLoading();
      Get.snackbar(Strings.error, e.toString());
    }
  }
}
