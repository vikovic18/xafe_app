import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/button.dart';
import 'package:xafe/widgets/reusable_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: AppColors.greyColor)),
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
            SizedBox(height: 5),
            const BodyText(
                color: AppColors.darkGreyColor,
                size: 14,
                text: 'Login to your account',
                weight: FontWeight.w400),
            SizedBox(height: 14),
            ReusableTextField(
                controller: emailController, hintText: "email address"),
            SizedBox(height: 10),
            ReusableTextField(
                controller: passwordController,
                hintText: 'password',
                isObscure: true,
                suffix: Icon(Icons.password)),
            SizedBox(
              height: 25,
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.centerRight,
                child: 
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        primary: AppColors.textFieldColor,
                        shape: const StadiumBorder()),
                      child: const BodyText(
                          color: AppColors.blackColor,
                          size: 14,
                          text: 'forgot password ?',
                          weight: FontWeight.w400))
              ),
            )
          ],
        ),
      )),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(onPressed: (){}, text: 'Login')),
    );
  }
}
