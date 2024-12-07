import 'package:flutter/cupertino.dart';
import 'package:product_catalogue/utils/constant/size.dart';

class SpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
      top: CustomSize.appBarHeight,
      left: CustomSize.defaultSpace,
      right: CustomSize.defaultSpace,
      bottom: CustomSize.defaultSpace
  );
}