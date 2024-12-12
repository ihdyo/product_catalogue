import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/constant/strings.dart';

class OrderedProductModel {
  final String productId;
  final double price;
  final int quantity;

  OrderedProductModel({
    required this.productId,
    required this.price,
    required this.quantity
  });

  static OrderedProductModel empty() =>
      OrderedProductModel(
          productId: '',
          price: 0,
          quantity: 0
      );

  Map<String, dynamic> toJson() {
    return {
      Strings.fieldProductId: productId,
      Strings.fieldPrice: price,
      Strings.fieldQuantity: quantity
    };
  }

  factory OrderedProductModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data() ?? {};

      try {
        return OrderedProductModel(
          productId: data[Strings.fieldProductId] ?? '',
          price: (data[Strings.fieldPrice] ?? 0).toDouble(),
          quantity: data[Strings.fieldQuantity] ?? 0,
        );
      } catch (e) {
        return OrderedProductModel.empty();
      }
    } else {
      return OrderedProductModel.empty();
    }
  }
}