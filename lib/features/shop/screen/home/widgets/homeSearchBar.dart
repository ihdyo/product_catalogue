import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/features/shop/screen/search.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../../../utils/validator/validation.dart';
import '../../../controller/search/searchController.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key
  });

  void _handleSearch(BuildContext context, SearchQueryController searchController) async {
    searchController.fetchProductsByPrefix(searchController.searchField.text);

    searchController.fetchProductsByPrefix(searchController.searchField.text);

    if (searchController.searchField.text.isNotEmpty &&
        searchController.products.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => SearchPage(productsQueried: searchController.products),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchController = Get.put(SearchQueryController());
    final dark = Helper.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.only(
          top: CustomSize.defaultSpace,
          left: CustomSize.defaultSpace,
          right: CustomSize.defaultSpace
      ),
      child: Form(
        key: searchController.searchFormKey,
        child: TextFormField(
          controller: searchController.searchField,
          validator: (value) => Validator.validateEmptyText(Strings.search, value),
          onFieldSubmitted: (value) async {
            _handleSearch(context, searchController);
          },
          inputFormatters: [
            TextInputFormatter.withFunction((oldValue, newValue) {
              String text = newValue.text;
              if (text.isNotEmpty) {
                text = text[0].toUpperCase() + text.substring(1);
              }
              return newValue.copyWith(text: text, selection: TextSelection.collapsed(offset: text.length));
            })
          ],
          decoration: InputDecoration(
            filled: true,
            fillColor: dark ? Colors.grey[800] : Colors.grey[200],
            hintText: Strings.search,
            hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: dark ? Colors.grey[400] : Colors.grey[600]
            ),
            suffixIcon: GestureDetector(
              onTap: () async {
                _handleSearch(context, searchController);
              },
              child: Icon(
                IconsaxPlusLinear.search_normal_1,
                color: dark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}