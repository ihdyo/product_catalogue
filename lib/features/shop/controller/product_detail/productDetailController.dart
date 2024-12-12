import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:product_catalogue/features/authentication/data/onboarding/onboardingPageData.dart';
import 'package:product_catalogue/features/authentication/screen/login/login.dart';

import '../../../../utils/constant/strings.dart';

class ProductDetailController extends GetxController {
  static ProductDetailController get instance => Get.find();

  final pageController = PageController();

  RxInt currentPageIndex = 0.obs;

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void indicatorClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    int page = currentPageIndex.value + 1;
    pageController.animateToPage(
      page,
      duration: Duration(
          milliseconds: 300
      ),
      curve: Curves.easeInOut,
    );
  }
}