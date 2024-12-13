import 'package:product_catalogue/utils/formatter/formatter.dart';

import '../../../../utils/constant/strings.dart';
import '../../../../utils/helper/calculator.dart';
import '../../controller/order/orderController.dart';

final controller = OrderController.instance;

List<Map<String, String>> get invoiceData {
  final int totalItems = controller.productsByOrder.fold<int>(0, (previousValue, element) => previousValue + element.quantity);
  final double totalPrice = Calculator.totalItemPrice(
    controller.productsByOrder,
    controller.orders,
  );
  final double shippingPrice = controller.orderById.value.shippingPrice;
  final double grandTotal = totalPrice + shippingPrice;

  return [
    {
      Strings.key: Strings.totalItem(totalItems),
      Strings.value: Formatter.formatCurrency(totalPrice),
    },
    {
      Strings.key: Strings.shipment,
      Strings.value: Formatter.formatCurrency(shippingPrice),
    },
    {
      Strings.key: Strings.grandTotal,
      Strings.value: Formatter.formatCurrency(grandTotal),
    },
  ];
}