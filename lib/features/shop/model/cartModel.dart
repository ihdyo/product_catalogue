import '../../../utils/constant/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  final String productId;
  final int quantity;
  final bool isSelected;

  CartModel({
    required this.productId,
    required this.quantity,
    required this.isSelected
  });

  static CartModel empty() =>
      CartModel(
          productId: '',
          quantity: 0,
          isSelected: false
      );

  Map<String, dynamic> toJson() {
    return {
      Strings.fieldProductId: productId,
      Strings.fieldQuantity: quantity,
      Strings.fieldIsSelected: isSelected
    };
  }

  factory CartModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data() ?? {};

      return CartModel(
        productId: data[Strings.fieldProductId] ?? '',
        quantity: data[Strings.fieldQuantity] ?? 0,
        isSelected: data[Strings.fieldIsSelected] ?? false
      );
    } else {
      return CartModel.empty();
    }
  }
}