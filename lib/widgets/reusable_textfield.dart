import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';

class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.isObscure = false,
      this.suffix = const SizedBox()
      })
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: AppColors.textFieldColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greyColor)),
      child: TextField(
          obscureText: isObscure ? true : false,
          controller: controller,
          decoration: InputDecoration(
              suffix: suffix,
              border: InputBorder.none,
              focusedBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText)),
    );
  }
}
