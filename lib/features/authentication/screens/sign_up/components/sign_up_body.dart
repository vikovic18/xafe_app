import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/utils/colors.dart';


class SignUpBody extends StatelessWidget {
  const SignUpBody(
      {Key? key,
      required this.controller,
      required this.title,
      required this.subtitle,
      this.isObscure = false,
      required this.keyboardType,
      required this.onPressed})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String subtitle;
  final TextInputType keyboardType;
  final VoidCallback onPressed;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: AppColors.greyColor)),
          centerTitle: true,
          title: const BodyText(
              color: AppColors.blackColor,
              size: 16,
              text: 'Signup',
              weight: FontWeight.w600)),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 24, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                  color: AppColors.blackColor,
                  size: 36,
                  text: title,
                  weight: FontWeight.w700),
              const SizedBox(height: 12),
              TextField(
                style: const TextStyle(
                  fontFamily: 'Euclid',
                  fontSize: 23
                ),
                textAlign: TextAlign.start,
                obscureText: isObscure ? true : false,
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  label: BodyText(
                      color: AppColors.greyColor,
                      size: 18,
                      text: subtitle,
                      weight: FontWeight.w400),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(onPressed: onPressed, text: 'Next')),
    );
  }
}
