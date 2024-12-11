import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constant/strings.dart';

class RecentController extends GetxController {
  var recentItems = <String>[].obs;

  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    if (_storage.read(Strings.recent) != null) {
      recentItems.value = List<String>.from(_storage.read(Strings.recent).reversed);
    }
  }

  void addItem(String itemId) {
    recentItems.remove(itemId);

    recentItems.insert(0, itemId);

    if (recentItems.length > 5) {
      recentItems.removeLast();
    }

    _storage.write(Strings.recent, recentItems.reversed.toList());
  }
}