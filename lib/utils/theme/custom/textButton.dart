import 'package:flutter/material.dart';

class CustomTextButtonTheme {
  CustomTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(
        color: Colors.blue[500]
      )
    )
  );

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: TextStyle(
        color: Colors.blue[400]
      )
    )
  );

}