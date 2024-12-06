import 'package:flutter/material.dart';

class CustomTextTheme {
  CustomTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    titleMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    titleSmall: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.black
    ),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black
    ),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black
    ),
    bodySmall: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.black
    )
  );
  static TextTheme darkTextTheme = TextTheme().copyWith(
    headlineLarge: const TextStyle().copyWith(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    headlineMedium: const TextStyle().copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    headlineSmall: const TextStyle().copyWith(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    titleLarge: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    titleMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    titleSmall: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white
    ),
    bodyLarge: const TextStyle().copyWith(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white
    ),
    bodyMedium: const TextStyle().copyWith(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white
    ),
    bodySmall: const TextStyle().copyWith(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white
    )
  );
}