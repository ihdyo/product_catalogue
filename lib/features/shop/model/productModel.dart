import 'package:product_catalogue/utils/constant/images.dart';

import '../../../utils/constant/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String categoryId;
  final String name;
  final String description;
  final List<String> images;
  final double price;
  final int stock;
  final double star;
  final int reviewer;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.stock,
    required this.star,
    required this.reviewer
  });

  static ProductModel empty() =>
      ProductModel(
          id: '',
          categoryId: '',
          name: '',
          description: '',
          images: [Images.placeholder],
          price: 0,
          stock: 0,
          star: 0,
          reviewer: 0
      );

  Map<String, dynamic> toJson() {
    final rating = {Strings.fieldStar: star, Strings.fieldReviewer: reviewer};

    return {
      Strings.fieldId: id,
      Strings.fieldCategoryId: categoryId,
      Strings.fieldName: name,
      Strings.fieldDescription: description,
      Strings.fieldImages: images,
      Strings.fieldPrice: price,
      Strings.fieldStock: stock,
      Strings.fieldRating: rating
    };
  }

  factory ProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data() ?? {};

      final star = data[Strings.fieldRating] is Map ? Map<String, dynamic>.from(data[Strings.fieldRating]) : {};
      final reviewer = data[Strings.fieldRating] is Map ? Map<String, dynamic>.from(data[Strings.fieldRating]) : {};

      return ProductModel(
        id: data[Strings.fieldId] ?? '',
        categoryId: data[Strings.fieldCategoryId] ?? '',
        name: data[Strings.fieldName] ?? '',
        description: data[Strings.fieldDescription] ?? '',
        images: data[Strings.fieldImages] is List
            ? List<String>.from(data[Strings.fieldImages])
            : [Images.placeholder],
        price: (data[Strings.fieldPrice] ?? 0).toDouble(),
        stock: data[Strings.fieldStock] ?? 0,
        star: star[Strings.fieldStar] ?? 0,
        reviewer: reviewer[Strings.fieldReviewer] ?? 0
      );
    } else {
      return ProductModel.empty();
    }
  }
}