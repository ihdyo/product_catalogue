import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_catalogue/utils/constant/enum.dart';

import '../../../utils/constant/strings.dart';

class OrderModel {
  final String id;
  DateTime orderedAt;
  String address;
  DateTime date;
  String recipient;
  double shippingPrice;
  double totalPrice;
  OrderStatus status;
  String paymentMethod;
  String paymentId;
  String note;

  OrderModel({
    required this.id,
    required this.orderedAt,
    required this.address,
    required this.date,
    required this.recipient,
    required this.shippingPrice,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
    required this.paymentId,
    required this.note,
  });

  static OrderModel empty() =>
      OrderModel(
        id: '',
        orderedAt: DateTime.now(),
        address: '',
        date: DateTime.now(),
        recipient: '',
        shippingPrice: 0,
        totalPrice: 0,
        status: OrderStatus.processing,
        paymentMethod: '',
        paymentId: '',
        note: '',
      );

  Map<String, dynamic> toJson() {
    return {
      Strings.fieldId: id,
      Strings.fieldOrderedAt: orderedAt,
      Strings.fieldAddress: address,
      Strings.fieldDate: date,
      Strings.fieldRecipient: recipient,
      Strings.fieldShippingPrice: shippingPrice,
      Strings.fieldTotalPrice: totalPrice,
      Strings.fieldStatus: status.name,
      Strings.fieldPaymentMethod: paymentMethod,
      Strings.fieldPaymentId: paymentId,
      Strings.fieldNote: note,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data() ?? {};

      try {
        return OrderModel(
          id: data[Strings.fieldId] ?? '',
          orderedAt: (data[Strings.fieldOrderedAt] as Timestamp).toDate(),
          address: data[Strings.fieldAddress] ?? '',
          date: (data[Strings.fieldDate] as Timestamp).toDate(),
          recipient: data[Strings.fieldRecipient] ?? '',
          shippingPrice: (data[Strings.fieldShippingPrice] ?? 0).toDouble(),
          totalPrice: (data[Strings.fieldTotalPrice] ?? 0).toDouble(),
          status: OrderStatusExtension.fromString(data[Strings.fieldStatus] ?? Strings.processing),
          paymentMethod: data[Strings.fieldPaymentMethod] ?? '',
          paymentId: data[Strings.fieldPaymentId] ?? '',
          note: data[Strings.fieldNote] ?? '',
        );
      } catch (e) {
        return OrderModel.empty();
      }
    } else {
      return OrderModel.empty();
    }
  }
}