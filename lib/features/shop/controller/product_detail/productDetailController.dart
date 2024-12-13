import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

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