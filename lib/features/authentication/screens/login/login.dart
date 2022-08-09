import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/authentication/controllers/auth_controller.dart';
import 'package:xafe/utils/colors.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser(context) {
    ref.read(authControllerProvider).signInWithEmailAndPassword(
        context, emailController.text.trim(), passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: AppColors.greyColor)),
      ),
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 24, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BodyText(
                color: AppColors.blackColor,
                size: 24,
                text: "Welcome back",
                weight: FontWeight.w600),
            const SizedBox(height: 5),
            const BodyText(
                color: AppColors.darkGreyColor,
                size: 14,
                text: 'Login to your account',
                weight: FontWeight.w400),
            const SizedBox(height: 14),
            ReusableTextField(
              controller: emailController,
              hintText: "email address",
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            ReusableTextField(
                controller: passwordController,
                keyboardType: TextInputType.name,
                hintText: 'password',
                isObscure: true,
                suffix: const Icon(Icons.password)),
            SizedBox(
              height: size.height*0.03,
            ),
            Container(
              margin: const EdgeInsets.only(right: 20),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: AppColors.textFieldColor,
                          shape: const StadiumBorder()),
                      child: const BodyText(
                          color: AppColors.blackColor,
                          size: 14,
                          text: 'forgot password ?',
                          weight: FontWeight.w400))),
            )
          ],
        ),
      )),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(onPressed: () => loginUser(context), text: 'Login')),
    );
  }
}
