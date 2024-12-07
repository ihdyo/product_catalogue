import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: CustomSize.spaceBetweenSections
          ),
          child: Column(
            children: [
              TextFormField(
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
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                      IconsaxPlusLinear.call
                  ),
                  labelText: Strings.phoneNumber,
                ),
              ),
              const SizedBox(
                  height: CustomSize.spaceBetweenItems
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                      IconsaxPlusLinear.password_check
                  ),
                  labelText: Strings.password,
                  suffixIcon: Icon(
                      IconsaxPlusBold.eye_slash
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(
                  height: CustomSize.spaceBetweenSections
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const HomePage()
                      //   )
                      // );
                    },
                    child: const Text(
                        Strings.registerButton
                    )
                ),
              )
            ],
          ),
        )
    );
  }
}