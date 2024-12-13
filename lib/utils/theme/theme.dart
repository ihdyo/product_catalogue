import 'package:flutter/material.dart';
import 'package:product_catalogue/utils/theme/custom/bottomsheet.dart';
import 'package:product_catalogue/utils/theme/custom/chip.dart';
import 'package:product_catalogue/utils/theme/custom/textButton.dart';
import 'package:product_catalogue/utils/theme/custom/elevatedButton.dart';
import 'package:product_catalogue/utils/theme/custom/text.dart';
import 'package:product_catalogue/utils/theme/custom/textField.dart';

import 'custom/appbar.dart';
import 'custom/checkbox.dart';
import 'custom/outlinedButton.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: Colors.blue[500]!,
      secondary: Colors.blue[600]!,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: CustomTextTheme.lightTextTheme,
    chipTheme: CustomChipTheme.lightChipTheme,
    appBarTheme: CustomAppBarTheme.lightAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlineButtonTheme.lightOutlinedButtonTheme,
    textButtonTheme: CustomTextButtonTheme.lightTextButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue[400]!,
      secondary: Colors.blue[300]!,
      surface: Colors.black,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: CustomTextTheme.darkTextTheme,
    chipTheme: CustomChipTheme.darkChipTheme,
    appBarTheme: CustomAppBarTheme.darkAppBarTheme,
    checkboxTheme: CustomCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: CustomBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: CustomElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: CustomOutlineButtonTheme.darkOutlinedButtonTheme,
    textButtonTheme: CustomTextButtonTheme.darkTextButtonTheme,
    inputDecorationTheme: CustomTextFieldTheme.darkInputDecorationTheme,
  );
}