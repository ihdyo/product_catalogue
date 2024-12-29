import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/common/widgets/shop/temporaryCounter.dart';

import '../../../features/shop/controller/home/productController.dart';
import '../../../features/shop/screen/product_detail/productDetail.dart';
import '../../../utils/constant/images.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/formatter/formatter.dart';
import '../../../utils/helper/helper.dart';
import '../../styles/shadow.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
  });

  final String id, image, name;
  final double price;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final dark = Helper.isDarkMode(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            id: id,
                          )
                      )
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      ShadowStyle().shadowMedium()
                    ],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (_, __, ___) {
                            return Image.asset(
                              Images.placeholder,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            );
                          },
                        ),
                      ),
                      if (productController.products.firstWhere((product) => product.id == id).stock == 0) Container(
                        decoration: BoxDecoration(
                          color: dark ? Colors.black.withOpacity(0.5) : Colors.white.withOpacity(0.5),
                        ),
                        child: const Center(
                          child: Text(
                            Strings.emptyStock
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: CustomSize.defaultSpace / 4,
                right: CustomSize.defaultSpace / 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Obx(() {
                    bool isWishlist = productController.isProductInWishlist(id);
                    return IconButton(
                      visualDensity: VisualDensity.compact,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      icon: Icon(
                          isWishlist ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart
                      ),
                      color: dark ? Colors.red[400] : Colors.red[500],
                      onPressed: () {
                        isWishlist
                            ? productController.removeProductFromWishlist(id)
                            : productController.addProductToWishlist(id);
                      },
                    );
                  }),
                ),
              ),
              TemporaryCounter(
                id: id,
                width: double.infinity,
                lightColor: Colors.white,
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      id: id,
                    )
                )
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(
              top: CustomSize.defaultSpace / 4,
              left: CustomSize.defaultSpace / 4,
              bottom: CustomSize.defaultSpace / 4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: CustomSize.defaultSpace / 8),
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: dark ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: CustomSize.defaultSpace / 8),
                Text(
                  Formatter.formatCurrency(price),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}