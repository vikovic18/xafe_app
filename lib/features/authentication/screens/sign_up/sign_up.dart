import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/utils/colors.dart';


class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BodyText(
          color: AppColors.blackColor,
          size: 15,
          text: 'Hello',
          weight: FontWeight.w600),
    );
  }
}
