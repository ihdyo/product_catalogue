import 'package:flutter/material.dart';
import 'package:product_catalogue/common/widgets/title.dart';
import 'package:product_catalogue/features/navigation/screen/widgets/addToCartFAB.dart';
import 'package:product_catalogue/features/shop/model/productModel.dart';

import '../../../../common/widgets/shop/productItem.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    required this.productsQueried
  });

  final List<ProductModel> productsQueried;

  @override
  Widget build(BuildContext context) {
    
    final itemCount = productsQueried.length;
    
    return Scaffold(
      floatingActionButton: AddToCartFAB(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: CustomSize.spaceBetweenSections
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(
                title: '',
                hasBackButton: true,
                isSection: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CustomSize.defaultSpace
                ),
                child: Text(
                  Strings.searchResult(itemCount),
                ),
              ),
              GridView.builder(
                padding: const EdgeInsets.only(
                  top: CustomSize.defaultSpace,
                  right: CustomSize.defaultSpace,
                  left: CustomSize.defaultSpace,
                  bottom: CustomSize.spaceBetweenSections,
                ),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: CustomSize.spaceBetweenItems,
                  mainAxisSpacing: CustomSize.spaceBetweenItems,
                  childAspectRatio: 3 / 5,
                ),
                itemCount: productsQueried.length,
                itemBuilder: (context, index) {
                  return ProductItem(
                    id: productsQueried[index].id,
                    image: productsQueried[index].images.first,
                    name: productsQueried[index].name,
                    price: productsQueried[index].price,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
