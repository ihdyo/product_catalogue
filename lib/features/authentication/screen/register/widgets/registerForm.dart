import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import '../../../../../navigation/navigationMenu.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = Helper.isDarkMode(context);

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
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const NavigationMenu()
                          )
                      );
                    },
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