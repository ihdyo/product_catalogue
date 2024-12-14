import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/styles/shimmer.dart';
import 'package:product_catalogue/features/shop/controller/cart/cartController.dart';
import 'package:product_catalogue/features/shop/controller/product_detail/productDetailController.dart';
import 'package:product_catalogue/features/shop/controller/temporary/temporaryController.dart';
import 'package:product_catalogue/features/shop/screen/product_detail/widgets/productDetailDetail.dart';
import 'package:product_catalogue/utils/constant/images.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/styles/InverseRound.dart';
import '../../../../common/styles/shadow.dart';
import '../../../../utils/constant/enum.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../../../../utils/constant/value.dart';
import '../../../../utils/helper/calculator.dart';
import '../../../../utils/helper/helper.dart';
import '../../../../utils/helper/idGenerator.dart';
import '../../../personalization/controller/user/userController.dart';
import '../../controller/home/productController.dart';
import '../../controller/home/recentController.dart';
import '../../controller/order/orderController.dart';
import '../../model/cartModel.dart';
import '../../model/orderModel.dart';
import '../../model/orderedProductModel.dart';
import '../order_status/orderStatus.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.id
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final recentController = Get.find<RecentController>();
    final cartController = CartController.instance;
    final userController = UserController.instance;
    final orderController = OrderController.instance;
    final productController = ProductController.instance;
    final temporaryController = TemporaryController.instance;
    final imageController = Get.put(ProductDetailController());
    final dark = Helper.isDarkMode(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      productController.fetchProductById(id);
      recentController.addItem(id);
    });

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          productController.fetchProductsByIds(recentController.recentItems);
        }
      },
      child: Obx(
          () => productController.isLoading.value ?
          const Center(child: CircularProgressIndicator())
          : Scaffold(
          body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          ClipPath(
                            clipper: InverseCurvedEdge(),
                            child: AspectRatio(
                              aspectRatio: 4 / 5,
                              child: PageView(
                                controller: imageController.pageController,
                                onPageChanged: imageController.updatePageIndicator,
                                children: [
                                  for (var image in productController.productById.value.images)
                                    Image.network(
                                        image,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return const CustomShimmer(
                                                width: double.infinity,
                                                height: double.infinity
                                            );
                                          }
                                        },
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                              Images.placeholder,
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover
                                          );
                                        }
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: CustomSize.defaultSpace * 2,
                            left: CustomSize.defaultSpace,
                            right: CustomSize.defaultSpace,
                            child: Center(
                              child: SmoothPageIndicator(
                                  controller: imageController.pageController,
                                  count: productController.productById.value.images.length,
                                  onDotClicked: imageController.indicatorClick,
                                  effect: ExpandingDotsEffect(
                                      activeDotColor: dark ? Colors.white : Colors.black,
                                      dotWidth: 4,
                                      dotHeight: 4
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                      ProductDetail(
                        id: id,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: CustomSize.appBarHeight,
                    left: CustomSize.defaultSpace,
                    right: CustomSize.defaultSpace,
                  ),
                  child: Row(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(
                              CustomSize.defaultSpace / 2
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dark ? Colors.black : Colors.white,
                            boxShadow: [
                              ShadowStyle().shadowSmall()
                            ],
                          ),
                          child:
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                                IconsaxPlusLinear.arrow_left,
                                color: dark ? Colors.white : Colors.black
                            ),
                          )
                      ),
                      const Spacer(),
                      Container(
                          padding: const EdgeInsets.all(
                              CustomSize.defaultSpace / 2
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dark ? Colors.black : Colors.white,
                            boxShadow: [
                              ShadowStyle().shadowSmall()
                            ],
                          ),
                          child:
                          Obx(() {
                            bool isWishlist = productController.isProductInWishlist(id);
                            return GestureDetector(
                              onTap: () {
                                isWishlist
                                    ? productController.removeProductFromWishlist(id)
                                    : productController.addProductToWishlist(id);
                              },
                              child: Icon(
                                isWishlist ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart,
                                color: dark ? Colors.red[400] : Colors.red[500],
                              ),
                            );
                          }),
                      ),
                    ],
                  ),
                )
              ]
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: CustomSize.defaultSpace / 2,
                horizontal: CustomSize.defaultSpace
            ),
            child: Obx(() {
              final isAvailable = productController.productById.value.stock >= temporaryController.getProductQuantityById(id);

              return Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (!isAvailable || temporaryController.getProductQuantityById(id) == 0) ? null : () async {
                        String recipient = userController.user.value.name;
                        String address = userController.user.value.address;
                        double grandTotal = Calculator.selectedWishlistPrice(
                          cartController.cartProducts.values.toList(),
                          cartController.cartProduct,
                        ) + Values.estimatedShippingPrice;
                        String orderId = IDBuilder.orderId(recipient, address);

                        await orderController.createOrder(
                            OrderModel(
                                id: orderId,
                                orderedAt: DateTime.now(),
                                address: address,
                                date: DateTime.now().add(Duration(days: Values.estimatedShippingDays)),
                                recipient: recipient,
                                shippingPrice: Values.estimatedShippingPrice,
                                totalPrice: grandTotal,
                                status: OrderStatus.processing,
                                paymentMethod: '',
                                paymentId: '',
                                note: ''
                            )
                        );

                        await orderController.createProductByOrder(
                          orderId,
                          [OrderedProductModel(
                              productId: id,
                              price: productController.productById.value.price,
                              quantity: temporaryController.getProductQuantityById(id),
                          )],
                        );

                        await productController.updateProductStock(id, temporaryController.getProductQuantityById(id));

                        await orderController.fetchOrders();

                        Get.to(() => OrderStatusPage(
                          orderId: orderId,
                          readOnly: false,
                        ));
                      },
                      child: Text(
                        Strings.buyButton,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: dark ? Colors.black : Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                      width: CustomSize.defaultSpace / 2
                  ),
                  ElevatedButton(
                    onPressed: !isAvailable || temporaryController.getProductQuantityById(id) == 0 ? null : () {
                      cartController.modifyCart(
                        id,
                        CartModel(
                          productId: id,
                          quantity: temporaryController.getProductQuantityById(id),
                          isSelected: true,
                        ),
                      );
                      temporaryController.clearProducts();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(CustomSize.defaultSpace * 0.6),
                        backgroundColor: dark ? Colors.blue[900]!.withOpacity(0.5) : Colors.blue[50],
                        elevation: 0,
                        side: BorderSide.none,
                        shadowColor: Colors.transparent,
                        disabledIconColor: dark ? Colors.grey[400] : Colors.grey[500],
                        iconColor: dark ? Colors.blue[400] : Colors.blue[500]
                    ),
                    child: Icon(
                        IconsaxPlusLinear.shopping_bag
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}