import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/controller/home/productController.dart';

import '../../../features/shop/controller/home/recentController.dart';
import '../../../features/shop/screen/product_detail/productDetail.dart';
import '../../../utils/constant/images.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/formatter/formatter.dart';
import '../../../utils/helper/helper.dart';
import '../../styles/shadow.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.index,
    required this.image,
    required this.name,
    required this.price,
    this.quantity = 0,
    this.isWishlist = false,
  });

  final String image, name;
  final double price;
  final int index, quantity;
  final bool isWishlist;

  @override
  Widget build(BuildContext context) {
    final recentController = Get.find<RecentController>();
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
                  final getIdByIndex = productController.products[index].id;
                  recentController.addItem(getIdByIndex);

                  Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            index: index,
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
                  child: ClipRRect(
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
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                        isWishlist ? IconsaxPlusBold.heart : IconsaxPlusLinear.heart
                    ),
                    color: dark ? Colors.red[400] : Colors.red[500],
                    onPressed: () {},
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                      bottom: CustomSize.defaultSpace / 4,
                      left: CustomSize.defaultSpace / 4,
                      right: CustomSize.defaultSpace / 4
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: dark ? Colors.grey[900] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          IconsaxPlusLinear.minus,
                          color: dark ? Colors.grey[400] : Colors.grey[600]!.withOpacity(quantity <= 0 ? 0 : 1),
                        ),
                        onPressed: quantity <= 0 ? null : () {},
                      ),
                      Text(
                        quantity.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          IconsaxPlusLinear.add,
                          color: dark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      index: 0,
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