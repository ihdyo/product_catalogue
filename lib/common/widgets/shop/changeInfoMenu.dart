import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../features/shop/controller/order/orderChangeAddressController.dart';
import '../../../features/shop/controller/order/orderChangeRecipientController.dart';
import '../../../features/shop/controller/order/orderController.dart';
import '../../../utils/constant/size.dart';
import '../../../utils/constant/strings.dart';
import '../../../utils/helper/helper.dart';
import '../../../utils/validator/validation.dart';
import '../title.dart';

class ChangeInfoMenu extends StatelessWidget {
  const ChangeInfoMenu({super.key,});

  @override
  Widget build(BuildContext context) {
    final orderController = OrderController.instance;
    final orderChangeRecipientController = Get.put(OrderChangeRecipientController());
    final orderChangeAddressController = Get.put(OrderChangeAddressController());
    final dark = Helper.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        showMenu(
            context: context,
            color: dark ? Colors.grey[900] : Colors.grey[50],
            position: RelativeRect.fromLTRB(100, 272, 24, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: dark ? Colors.grey[800]! : Colors.grey[200]!,
                width: 1,
              ),
            ),
            elevation: 0,
            items: [
              PopupMenuItem(
                child: Text(Strings.changeRecipient),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: dark ? Colors.grey[900] : Colors.grey[50],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16)
                          )
                      ),
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: CustomSize.defaultSpace / 2
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTitle(
                                    title: Strings.changeRecipient
                                ),
                                Form(
                                  key : orderChangeRecipientController.orderChangeRecipientFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: CustomSize.defaultSpace
                                    ),
                                    child: Column(
                                        children: [
                                          TextFormField(
                                            controller: orderChangeRecipientController.recipient,
                                            validator: (value) => Validator.validateEmptyText(Strings.recent, value),
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: Strings.recent,
                                            ),
                                          ),
                                          const SizedBox(height: CustomSize.spaceBetweenItems),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                orderChangeRecipientController.changeRecipient(() {
                                                  Navigator.pop(context);
                                                });
                                                orderController.fetchOrderById(orderController.orderById.value.id);
                                              },
                                              child: Text(
                                                  Strings.change
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
              ),
              PopupMenuItem(
                child: Text(Strings.changeAddress),
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: dark ? Colors.grey[900] : Colors.grey[50],
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16)
                          )
                      ),
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: CustomSize.defaultSpace / 2
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTitle(
                                    title: Strings.changeAddress
                                ),
                                Form(
                                  key : orderChangeAddressController.orderChangeAddressFormKey,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: CustomSize.defaultSpace
                                    ),
                                    child: Column(
                                        children: [
                                          TextFormField(
                                            controller: orderChangeAddressController.address,
                                            validator: (value) => Validator.validateEmptyText(Strings.address, value),
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelText: Strings.address,
                                            ),
                                          ),
                                          const SizedBox(height: CustomSize.spaceBetweenItems),
                                          SizedBox(
                                            width: double.infinity,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                orderChangeAddressController.changeAddress(() {
                                                  Navigator.pop(context);
                                                });
                                                orderController.fetchOrderById(orderController.orderById.value.id);
                                              },
                                              child: Text(
                                                  Strings.change
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                  );
                },
              ),
            ]
        );
      },
      child: Icon(
          IconsaxPlusLinear.edit,
          size: 20,
          color: dark ? Colors.grey[300] : Colors.grey[700]
      ),
    );
  }
}