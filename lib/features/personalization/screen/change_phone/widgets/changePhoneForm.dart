import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/validator/validation.dart';
import '../../../controller/profile/changePhoneController.dart';

class ChangePhoneForm extends StatelessWidget {
  const ChangePhoneForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePhoneController());

    return Form(
      key : controller.changePhoneFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSpace
        ),
        child: Column(
            children: [
              TextFormField(
                controller: controller.phone,
                validator: (value) => Validator.validateEmptyText(Strings.phoneNumber, value),
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: Strings.phoneNumber,
                ),
              ),
              const SizedBox(height: CustomSize.spaceBetweenItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.changePhone();
                  },
                  child: Text(
                      Strings.changePhone
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}