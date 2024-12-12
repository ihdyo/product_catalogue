import 'package:product_catalogue/utils/constant/strings.dart';

enum OrderStatus {
  processing,
  packing,
  shipping,
  delivered,
}

extension OrderStatusExtension on OrderStatus {
  String get name {
    switch (this) {
      case OrderStatus.processing:
        return Strings.processing;
      case OrderStatus.packing:
        return Strings.packing;
      case OrderStatus.shipping:
        return Strings.shipping;
      case OrderStatus.delivered:
        return Strings.delivered;
      default:
        return Strings.processing;
    }
  }

  static OrderStatus fromString(String status) {
    switch (status) {
      case Strings.processing:
        return OrderStatus.processing;
      case Strings.packing:
        return OrderStatus.packing;
      case Strings.shipping:
        return OrderStatus.shipping;
      case Strings.delivered:
        return OrderStatus.delivered;
      default:
        return OrderStatus.processing;
    }
  }
}
