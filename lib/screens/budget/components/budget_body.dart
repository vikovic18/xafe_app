import 'package:flutter/material.dart';
import 'package:xafe/screens/budget/components/budget_details.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/chart_bar.dart';

class BudgetBody extends StatelessWidget {
  const BudgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BudgetDetails()),
        );
      },
      child: Container(
        height: size.height * 0.14,
        width: size.height * 0.23,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                  color: AppColors.darkGreyColor,
                  size: 16,
                  text: 'Groceries',
                  weight: FontWeight.w400),
              BodyText(
                  color: AppColors.blackColor,
                  size: 20,
                  text: '\$40/month',
                  weight: FontWeight.w400),
              SizedBox(height: 12),
              ChartBar()
            ],
          ),
        ),
      ),
    );
  }
}
