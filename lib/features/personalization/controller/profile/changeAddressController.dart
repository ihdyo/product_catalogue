import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/utils/constant/strings.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../data/repository/user/userRepository.dart';
import '../../../../navigation/navigationMenu.dart';
import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';
import '../user/userController.dart';

class ChangeAddressController extends GetxController {
  static ChangeAddressController get instance => Get.find();

  final address = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> changeAddressFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchAddress();
  }

  Future<void> fetchAddress() async {
    address.text = userController.user.value.address;
  }

  Future<void> changeAddress() async {
    try {
      FullScreenLoading.openLoadingDialog();
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      if(!changeAddressFormKey.currentState!.validate()) {
        FullScreenLoading.stopLoading();
        return;
      }

      Map<String, dynamic> data = {Strings.fieldAddress: address.text.trim()};
      await userRepository.updateSingleField(data);

      userController.user.value.address = address.text.trim();

      Loading.successSnackBar(
          title: Strings.success,
          message: Strings.changeAddressMessages
      );

      Get.offAll(() => const NavigationMenu(), arguments: 2);
    } catch(e) {
      FullScreenLoading.stopLoading();
      Get.snackbar(Strings.error, e.toString());
    }
  }
}
