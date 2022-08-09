import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';


class ReusableTextField extends StatelessWidget {
  const ReusableTextField(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.keyboardType,
      this.isObscure = false,
      this.suffix = const SizedBox()
      })
      : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool isObscure;
  final Widget suffix;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height*0.08,
      margin: const EdgeInsets.only(right: 20),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
          color: AppColors.textFieldColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.greyColor)),
      child: TextField(
          obscureText: isObscure ? true : false,
          keyboardType: keyboardType,
          controller: controller,
          decoration: InputDecoration(
              hintStyle: const TextStyle(
                fontFamily: 'Euclid',
                fontSize: 14,
                color: AppColors.blackColor
              ),
              suffix: suffix,
              border: InputBorder.none,
              focusedBorder:
                  const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText)),
    );
  }
}
