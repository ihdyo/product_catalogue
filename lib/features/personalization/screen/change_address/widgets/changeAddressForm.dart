import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/validator/validation.dart';
import '../../../controller/profile/changeAddressController.dart';

class ChangeAddressForm extends StatelessWidget {
  const ChangeAddressForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeAddressController());

    return Form(
      key : controller.changeAddressFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSpace
        ),
        child: Column(
            children: [
              TextFormField(
                controller: controller.address,
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
                    controller.changeAddress();
                  },
                  child: Text(
                      Strings.changeAddress
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}