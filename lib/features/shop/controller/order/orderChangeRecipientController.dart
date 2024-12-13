import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/data/repository/order/orderRepository.dart';
import 'package:product_catalogue/features/shop/controller/order/orderController.dart';
import 'package:product_catalogue/utils/constant/strings.dart';
import 'package:product_catalogue/utils/popup/fullScreenLoading.dart';

import '../../../../utils/helper/networkManager.dart';
import '../../../../utils/popup/loading.dart';

class OrderChangeRecipientController extends GetxController {
  static OrderChangeRecipientController get instance => Get.find();

  final recipient = TextEditingController();
  final orderController = OrderController.instance;
  final orderRepository = Get.put(OrderRepository());
  GlobalKey<FormState> orderChangeRecipientFormKey = GlobalKey<FormState>();

  Future<void> changeRecipient(VoidCallback onSuccess) async {
    try {
      FullScreenLoading.openLoadingDialog();
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        FullScreenLoading.stopLoading();
        return;
      }

      if(!orderChangeRecipientFormKey.currentState!.validate()) {
        FullScreenLoading.stopLoading();
        return;
      }

      Map<String, dynamic> data = {Strings.fieldRecipient: recipient.text.trim()};
      await orderRepository.updateSingleField(orderController.orderById.value.id, data);

      orderController.orderById.value.recipient = recipient.text.trim();

      Loading.successSnackBar(
          title: Strings.success,
          message: Strings.changeRecipientMessages
      );

      FullScreenLoading.stopLoading();

      onSuccess();
    } catch(e) {
      FullScreenLoading.stopLoading();
      Get.snackbar(Strings.error, e.toString());
    }
  }
}
