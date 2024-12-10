import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/utils/validator/validation.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';
import '../../../controller/register/registerController.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final dark = Helper.isDarkMode(context);

    return Form(
      key: controller.registerFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: CustomSize.spaceBetweenSections
          ),
          child: Column(
            children: [
              TextFormField(
                controller: controller.name,
                validator: (value) => Validator.validateEmptyText(Strings.name, value),
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                      IconsaxPlusLinear.user
                  ),
                  labelText: Strings.name,
                ),
              ),
              const SizedBox(
                  height: CustomSize.spaceBetweenItems
              ),

              TextFormField(
                controller: controller.email,
                validator: (value) => Validator.validateEmail(value),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                      IconsaxPlusLinear.sms
                  ),
                  labelText: Strings.email,
                ),
              ),
              const SizedBox(
                  height: CustomSize.spaceBetweenItems
              ),

              Obx(
                () => TextFormField(
                  controller: controller.password,
                  validator: (value) => Validator.validatePassword(value),
                  keyboardType: TextInputType.text,
                  obscureText: controller.hidePassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                        IconsaxPlusLinear.password_check
                    ),
                    labelText: Strings.password,
                    suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                      icon: Icon(
                          controller.hidePassword.value ? IconsaxPlusLinear.eye_slash : IconsaxPlusLinear.eye
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: CustomSize.spaceBetweenItems
              ),

              Obx(
                () => TextFormField(
                  controller: controller.confirmPassword,
                  validator: (value) => Validator.validateConfirmPassword(value, controller.password.text),
                  keyboardType: TextInputType.text,
                  obscureText: controller.hideConfirmPassword.value,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                        IconsaxPlusLinear.password_check
                    ),
                    labelText: Strings.confirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () => controller.hideConfirmPassword.value = !controller.hideConfirmPassword.value,
                      icon: Icon(
                          controller.hideConfirmPassword.value ? IconsaxPlusLinear.eye_slash : IconsaxPlusLinear.eye
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  height: CustomSize.spaceBetweenSections
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => controller.emailAndPasswordRegister(),
                    child: Text(
                        Strings.registerButton,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: dark ? Colors.black : Colors.white
                        )
                    )
                ),
              )
            ],
          ),
        )
    );
  }
}