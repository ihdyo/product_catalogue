import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/utils/constant/images.dart';

import '../../../utils/constant/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String phrase;
  final IconData icon;
  final String image;
  final MaterialColor color;

  CategoryModel({
    required this.id,
    required this.name,
    required this.phrase,
    required this.icon,
    required this.image,
    required this.color
  });

  static CategoryModel empty() =>
      CategoryModel(
          id: '',
          name: '',
          phrase: '',
          image: Images.placeholder,
          icon: IconsaxPlusLinear.image,
          color: Colors.blue
      );

  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data()!;

      final iconFromString = {
        'Electronic': IconsaxPlusLinear.mouse,
        'Automotive': IconsaxPlusLinear.car,
        'Fashion': IconsaxPlusLinear.diamonds,
        'Hobby': IconsaxPlusLinear.musicnote,
        'Furniture': IconsaxPlusLinear.broom,
        'Groceries': IconsaxPlusLinear.blur,
      };

      final Map<String, MaterialColor> colorFromString = {
        'red': Colors.red,
        'deepOrange': Colors.deepOrange,
        'orange': Colors.orange,
        'amber': Colors.amber,
        'yellow': Colors.yellow,
        'lime': Colors.lime,
        'lightGreen': Colors.lightGreen,
        'green': Colors.green,
        'teal': Colors.teal,
        'cyan': Colors.cyan,
        'lightBlue': Colors.lightBlue,
        'blue': Colors.blue,
        'indigo': Colors.indigo,
        'deepPurple': Colors.deepPurple,
        'purple': Colors.purple,
        'pink': Colors.pink,
        'brown': Colors.brown,
        'grey': Colors.grey,
        'blueGrey': Colors.blueGrey
      };

      final String imagePath = 'assets/category/${data[Strings.fieldName]?.toLowerCase() ?? ''}.webp';

      final iconString = data[Strings.fieldName] ?? '';
      final colorString = data[Strings.fieldColor] ?? '';

      return CategoryModel(
        id: data[Strings.fieldId] ?? '',
        name: data[Strings.fieldName] ?? '',
        phrase: data[Strings.fieldPhrase] ?? '',
        icon: iconFromString[iconString] ?? IconsaxPlusLinear.image,
        image: imagePath,
        color: colorFromString[colorString] ?? Colors.blue,
      );
    } else {
      return CategoryModel.empty();
    }
  }
}