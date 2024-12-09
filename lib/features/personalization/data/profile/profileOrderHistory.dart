import 'package:product_catalogue/common/widgets/personalization/orderHistoryItem.dart';

import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/strings.dart';

final List<OrderHistoryItem> orderHistoryList = [
  OrderHistoryItem(
      date: Strings.placeholder,
      status: OrderStatus.delivered,
      itemCount: 1,
      totalPrice: 25000.0
  ),
  OrderHistoryItem(
      date: Strings.placeholder,
      status: OrderStatus.delivered,
      itemCount: 1,
      totalPrice: 25000.0
  ),
  OrderHistoryItem(
      date: Strings.placeholder,
      status: OrderStatus.delivered,
      itemCount: 5,
      totalPrice: 550000.0
  ),
];