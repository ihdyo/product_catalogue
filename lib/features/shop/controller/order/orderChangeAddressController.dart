import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/order/orderRepository.dart';
import 'package:product_catalogue/features/shop/controller/order/orderController.dart';
import 'package:product_catalogue/utils/constant/strings.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';

class OrderChangeAddressController extends GetxController {
  static OrderChangeAddressController get instance => Get.find();

  final address = TextEditingController();
  final orderController = OrderController.instance;
  final orderRepository = Get.put(OrderRepository());
  GlobalKey<FormState> orderChangeAddressFormKey = GlobalKey<FormState>();

  Future<void> changeAddress(VoidCallback onSuccess) async {
    try {
      FullScreenLoading.openLoadingDialog();
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      if(!orderChangeAddressFormKey.currentState!.validate()) {
        FullScreenLoading.stopLoading();
        return;
      }

      Map<String, dynamic> data = {Strings.fieldAddress: address.text.trim()};
      await orderRepository.updateSingleField(orderController.orderById.value.id, data);

      orderController.orderById.value.address = address.text.trim();

      Loading.successSnackBar(
          title: Strings.success,
          message: Strings.changeAddressMessages
      );

      FullScreenLoading.stopLoading();

      onSuccess();
    } catch(e) {
      FullScreenLoading.stopLoading();
      Get.snackbar(Strings.error, e.toString());
    }
  }
}
