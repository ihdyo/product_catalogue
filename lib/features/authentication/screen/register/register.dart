import 'package:flutter/material.dart';
import 'package:product_catalogue/common/styles/spacing.dart';
import 'package:product_catalogue/features/authentication/screen/login/login.dart';
import 'package:product_catalogue/features/authentication/screen/register/widgets/registerForm.dart';
import 'package:product_catalogue/utils/constant/strings.dart';

import '../../../../common/widgets/auth/authAgreements.dart';
import '../../../../common/widgets/auth/authAlternativeSignIn.dart';
import '../../../../common/widgets/auth/authDivider.dart';
import '../../../../common/widgets/auth/authHeader.dart';
import '../../../../utils/constant/size.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                      title: Strings.registerTitle,
                      body: Strings.registerBody,
                      navigateTo: Strings.loginButton,
                      navigation: LoginScreen(),
                    ),
                    RegisterForm(),
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
        }
      ),
      bottomNavigationBar: Agreements(),
    );
  }
}