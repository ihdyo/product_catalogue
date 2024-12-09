import 'package:product_catalogue/features/shop/screen/cart/widgets/cartProduct.dart';

import '../../../../../utils/constant/images.dart';
import '../../../../../utils/constant/strings.dart';

final List<CartProductItem> cartProductList = [
  CartProductItem(
    isChecked: true,
    isWishlist: true,
    image: Images.placeholder,
    name: Strings.developer,
    price: 10000,
    quantity: 2,
  ),
  CartProductItem(
    isChecked: true,
    isWishlist: true,
    image: Images.placeholder,
    name: Strings.developer,
    price: 50000,
    quantity: 1,
  ),
  CartProductItem(
    isChecked: true,
    isWishlist: false,
    image: Images.placeholder,
    name: Strings.developer,
    price: 30000,
    quantity: 4,
  ),
  CartProductItem(
    isChecked: true,
    isWishlist: false,
    image: Images.placeholder,
    name: Strings.developer,
    price: 10000,
    quantity: 2,
  ),
  CartProductItem(
    isChecked: false,
    isWishlist: false,
    image: Images.placeholder,
    name: Strings.developer,
    price: 50000,
    quantity: 1,
  ),
  CartProductItem(
    isChecked: false,
    isWishlist: false,
    image: Images.placeholder,
    name: Strings.developer,
    price: 30000,
    quantity: 4,
  ),
];