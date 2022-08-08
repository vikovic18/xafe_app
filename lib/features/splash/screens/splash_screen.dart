import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/features/authentication/screens/login/login.dart';
import 'package:xafe/features/authentication/screens/sign_up/components/sign_up_fields.dart';
import 'package:xafe/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  void navigateToSignUpScreen(BuildContext context) {
    Navigator.pushNamed(context, SignUpName.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.blackColor,
        body: SafeArea(
          child: Center(
            child:
                SingleChildScrollView(
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              const BodyText(
                    color: AppColors.whiteColor,
                    size: 32,
                    text: 'xafe',
                    weight: FontWeight.w600),
                              SizedBox(height: size.height * 0.02),
                              const BodyText(
                    color: AppColors.whiteColor,
                    size: 20,
                    text: 'Smart Budgeting',
                    weight: FontWeight.w600),
                              SizedBox(height: size.height * 0.2),
                              Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ButtonText(
                      text: 'Login',
                      onPressed: () => navigateToLoginScreen(context)),
                              ),
                              SizedBox(height: size.height * 0.02),
                              RichText(
                  text: TextSpan(
                      text: 'New here?',
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Euclid',
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w400,
                          height: 1.4),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => navigateToSignUpScreen(context),
                          text: ' Create an account',
                          style: const TextStyle(
                              fontFamily: 'Euclid',
                              fontSize: 16,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              height: 1.4),
                        )
                      ]),
                              ),
                              SizedBox(height: size.height * 0.10),
                              const Text(
                  "By continuing, you agree to Xafe's terms of use \n and privacy policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Euclid',
                      fontSize: 12,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w400,
                      height: 1.4),
                              )
                            ]),
                ),
          ),
        ));
  }
}
