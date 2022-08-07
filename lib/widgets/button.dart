import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: BodyText(
            color: AppColors.whiteColor,
            size: 16,
            text: text,
            weight: FontWeight.w700),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0)
        ),
              primary: AppColors.buttonColor,
              minimumSize: const Size(double.infinity, 60),
            ),
            
            );
  }
}
