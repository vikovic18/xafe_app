import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.height * 0.06,
      child: const Divider(
        thickness: 5,
        color: AppColors.greyColor,
      ),
    );
  }
}
