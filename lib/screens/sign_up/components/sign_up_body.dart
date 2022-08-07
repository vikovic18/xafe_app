import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/button.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody(
      {Key? key,
      required this.controller,
      required this.title,
      required this.subtitle,
      required this.onPressed})
      : super(key: key);

  final TextEditingController controller;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

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
              SizedBox(height: 12),
              TextField(
                textAlign: TextAlign.start,
                controller: controller,
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
