import 'package:get/get.dart';

import '../utils/helper/networkManager.dart';

class GeneralBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
