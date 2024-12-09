import 'package:get/get.dart';

import '../../features/shop/screen/profile/profile.dart';
import '../../features/shop/screen/home/home.dart';
import '../../features/shop/screen/wishlist/wishlist.dart';

class NavigationController extends GetxController {
  final Rx<int> currentIndex = 0.obs;

  final screens = [
    const HomePage(),
    const WishlistPage(),
    const ProfilePage()
  ];
}