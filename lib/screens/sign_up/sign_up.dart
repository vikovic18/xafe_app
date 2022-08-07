import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
// import 'package:xafe/utils/dimensions.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/button.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BodyText(
          color: AppColors.purpleColor,
          size: 15,
          text: 'Hello',
          weight: FontWeight.w600),
    );
  }
}
