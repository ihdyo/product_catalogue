import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:product_catalogue/utils/constant/enum.dart';

import '../../../utils/constant/strings.dart';

class OrderModel {
  final String id;
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
      Strings.fieldAddress: address,
      Strings.fieldDate: date,
      Strings.fieldRecipient: recipient,
      Strings.fieldShippingPrice: shippingPrice,
      Strings.fieldTotalPrice: totalPrice,
      Strings.fieldStatus: status,
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
          address: data[Strings.fieldAddress] ?? '',
          date: (data[Strings.fieldDate] as Timestamp).toDate(),
          recipient: data[Strings.fieldRecipient] ?? '',
          shippingPrice: (data[Strings.fieldShippingPrice] ?? 0).toDouble(),
          totalPrice: (data[Strings.fieldTotalPrice] ?? 0).toDouble(),
          status: OrderStatusExtension.fromString(data[Strings.fieldStatus] ?? ''),
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