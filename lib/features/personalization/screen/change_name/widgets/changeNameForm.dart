import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalogue/features/personalization/controller/change_name/changeNameController.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/validator/validation.dart';

class ChangeNameForm extends StatelessWidget {
  const ChangeNameForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangeNameController());

    return Form(
      key : controller.changeNameFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSpace
        ),
        child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                validator: (value) => Validator.validateEmptyText(Strings.name, value),
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: Strings.name,
                ),
              ),
              const SizedBox(height: CustomSize.spaceBetweenItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.changeName();
                  },
                  child: Text(
                      Strings.changeName
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}