import 'package:flutter/material.dart';
import 'package:product_catalogue/common/styles/spacing.dart';
import 'package:product_catalogue/features/authentication/screen/login/widgets/loginForm.dart';

import '../../../../common/widgets/auth/authAgreements.dart';
import '../../../../common/widgets/auth/authAlternativeSignIn.dart';
import '../../../../common/widgets/auth/authDivider.dart';
import '../../../../common/widgets/auth/authHeader.dart';
import '../../../../utils/constant/size.dart';
import '../../../../utils/constant/strings.dart';
import '../register/register.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: SpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AuthHeader(
                      title: Strings.loginTitle,
                      body: Strings.loginBody,
                      navigateTo: Strings.registerButton,
                      navigation: RegisterScreen()
                    ),
                    LoginForm(),
                    AuthDivider(),
                    const SizedBox(
                        height: CustomSize.spaceBetweenItems
                    ),
                    AlternativeSignIn(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Agreements(),
    );
  }
}