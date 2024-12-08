import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:product_catalogue/navigation/navigationMenu.dart';

import '../../../../../common/widgets/test/notImplemented.dart';
import '../../../../../utils/constant/size.dart';
import '../../../../../utils/constant/strings.dart';
import '../../../../../utils/helper/helper.dart';
import '../../register/register.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
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
                  height: CustomSize.spaceBetweenItems
              ),
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: Strings.forgotPassword,
                    style: Theme.of(context).textTheme.labelMedium,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Forgot Password
                        NotImplementedAlert.show(context);
                      },
                  ),
                ),
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
                        Strings.loginButton,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: dark ? Colors.black : Colors.white
                        )
                    )
                ),
              ),
              const SizedBox(
                  height: CustomSize.spaceBetweenItems
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen()
                        )
                      );
                    },
                    child: Text(
                        Strings.createAccountButton,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: dark ? Colors.grey[300] : Colors.grey[700]
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