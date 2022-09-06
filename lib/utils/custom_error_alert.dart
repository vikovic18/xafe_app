import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/utils/colors.dart';

Future<void> showCustomErrorDialog(BuildContext context, String text) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const BodyText(
              color: Colors.red,
              size: 16,
              text: 'An error occured',
              weight: FontWeight.w400),
          content: BodyText(
              color: AppColors.blackColor,
              size: 16,
              text: text,
              weight: FontWeight.w400),
          // contentPadding: EdgeInsets.all(14),
          alignment: Alignment.center,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const BodyText(
                    color: AppColors.blackColor,
                    size: 16,
                    text: 'Okay',
                    weight: FontWeight.w500))
          ],
        );
      });
}
