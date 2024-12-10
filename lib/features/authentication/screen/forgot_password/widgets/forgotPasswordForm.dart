import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/validator/validation.dart';
import '../../../controller/forgot_password/forgotPasswordController.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgotPasswordController());

    return Form(
      key : controller.forgotPasswordFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: CustomSize.defaultSpace
        ),
        child: Column(
            children: [
              TextFormField(
                controller: controller.email,
                validator: (value) => Validator.validateEmail(value) ?? Validator.validateEmptyText(Strings.email, value),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: Strings.email,
                ),
              ),
              const SizedBox(height: CustomSize.spaceBetweenItems),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.sendVerification();
                  },
                  child: Text(
                      Strings.sendVerification
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}