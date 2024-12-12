import 'package:product_catalogue/common/widgets/personalization/orderHistoryItem.dart';

import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/strings.dart';

final List<OrderHistoryItem> ongoingOrderList = [
  OrderHistoryItem(
      orderId: Strings.counter,
      date: Strings.placeholder,
      status: OrderStatus.packing,
      totalPrice: 100000.0
  ),
  OrderHistoryItem(
      orderId: Strings.counter,
      date: Strings.placeholder,
      status: OrderStatus.shipping,
      totalPrice: 25000.0
  ),
];