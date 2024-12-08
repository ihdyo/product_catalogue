import 'package:flutter/material.dart';
import 'package:product_catalogue/utils/theme/custom/bottomsheet.dart';
import 'package:product_catalogue/utils/theme/custom/chip.dart';
import 'package:product_catalogue/utils/theme/custom/elevated_button.dart';
import 'package:product_catalogue/utils/theme/custom/text.dart';
import 'package:product_catalogue/utils/theme/custom/textField.dart';

import 'custom/appbar.dart';
import 'custom/checkbox.dart';
import 'custom/outllined_button.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.lightTextTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlineButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.black,
    textTheme: CustomTextTheme.darkTextTheme,
    chipTheme: CustomChipTheme.darkChipTheme,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlineButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme,
  );
}