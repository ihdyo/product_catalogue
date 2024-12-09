import 'package:product_catalogue/common/widgets/shop/orderStatusIcon.dart';

import '../../../../utils/constant/enum.dart';

final List<OrderStatusItem> orderStatusList = [
  OrderStatusItem(
      status: OrderStatus.packing,
      showText: true,
      isActive: false,
  ),
  OrderStatusItem(
    status: OrderStatus.shipping,
    showText: true,
    isActive: false,
  ),
  OrderStatusItem(
    status: OrderStatus.delivered,
    showText: true,
    isActive: false,
  ),
];