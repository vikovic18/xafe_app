import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: AppColors.blackColor,
    content: Text(content,
        style: const TextStyle(
            fontFamily: 'Euclid', fontSize: 14, color: AppColors.whiteColor)),
  ));
}
