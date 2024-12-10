import 'package:flutter/material.dart';

class CustomOutlineButtonTheme {
  CustomOutlineButtonTheme._();

  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.black,
      side: const BorderSide(
          color: Colors.grey
      ),
      textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    ),
  );

  static final darkOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: Colors.white,
      side: const BorderSide(
          color: Colors.grey
      ),
      textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
      padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
    ),
  );
}