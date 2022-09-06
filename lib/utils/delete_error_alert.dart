
import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/utils/colors.dart';

Future<bool> showCustomDeleteDialog(BuildContext context) async {
  late bool result;
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const BodyText(
              color: Colors.red,
              size: 16,
              text: 'Are you sure?',
              weight: FontWeight.w400),
          content: const BodyText(
              color: AppColors.blackColor,
              size: 16,
              text: 'Do you want to delete?',
              weight: FontWeight.w400),
          // contentPadding: EdgeInsets.all(14),
          alignment: Alignment.center,
          actions: [
            TextButton(
                onPressed: () {
                   result = false;
                  Navigator.of(context).pop(false);
                },
                child: const BodyText(
                    color: AppColors.blackColor,
                    size: 16,
                    text: 'No',
                    weight: FontWeight.w500)),
            TextButton(
                onPressed: () {
                  result = true;
                  Navigator.of(context).pop(true);
                },
                child: const BodyText(
                    color: AppColors.blackColor,
                    size: 16,
                    text: 'Yes',
                    weight: FontWeight.w500))
          ],
        );
      });
      return result;
}
