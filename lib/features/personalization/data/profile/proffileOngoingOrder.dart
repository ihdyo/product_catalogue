import 'package:product_catalogue/common/widgets/personalization/orderHistoryItem.dart';

import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/strings.dart';

final List<OrderHistoryItem> ongoingOrderList = [
  OrderHistoryItem(
      date: Strings.placeholder,
      status: OrderStatus.packing,
      itemCount: 3,
      totalPrice: 100000.0
  ),
  OrderHistoryItem(
      date: Strings.placeholder,
      status: OrderStatus.shipping,
      itemCount: 1,
      totalPrice: 25000.0
  ),
];