import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/controller/temporary/temporaryController.dart';

import '../../../features/shop/controller/home/productController.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/helper/helper.dart';

class TemporaryCounter extends StatelessWidget {
  const TemporaryCounter({
    super.key,
    required this.id,
    required this.width,
    required this.lightColor,
  });

  final String id;
  final double width;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    final productController = ProductController.instance;
    final temporaryController = TemporaryController.instance;
    final dark = Helper.isDarkMode(context);

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: CustomSize.defaultSpace / 4,
          left: CustomSize.defaultSpace / 4,
          right: CustomSize.defaultSpace / 4,
        ),
        width: width,
        decoration: BoxDecoration(
          color: dark ? Colors.grey[900] : lightColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Obx(() {
          final quantity = temporaryController.getProductQuantityById(id);
          int stock = productController.products.firstWhere((product) => product.id == id).stock;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  IconsaxPlusLinear.minus,
                  color: dark
                      ? Colors.grey[400]!.withOpacity(quantity <= 0 ? 0.3 : 1)
                      : Colors.grey[600]!.withOpacity(quantity <= 0 ? 0.3 : 1),
                ),
                onPressed: quantity <= 0
                    ? null
                    : () {
                  final newQuantity = quantity - 1;
                  temporaryController.editProduct(id, newQuantity);
                },
              ),
              Text(
                quantity.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(
                  IconsaxPlusLinear.add,
                  color: dark
                      ? Colors.grey[400]!.withOpacity(quantity >= stock ? 0.3 : 1)
                      : Colors.grey[600]!.withOpacity(quantity >= stock ? 0.3 : 1),
                ),
                onPressed: quantity >= stock
                    ? null
                    : () {
                        final newQuantity = quantity + 1;
                        temporaryController.editProduct(id, newQuantity);
                      },
              ),
            ],
          );
        }),
      ),
    );
  }
}