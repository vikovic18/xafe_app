import 'package:flutter/material.dart';
import 'package:xafe/screens/budget/components/budget_details_body.dart';
import 'package:xafe/screens/budget/components/budget_edit_sheet.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/chart_bar.dart';

class BudgetDetails extends StatelessWidget {
  const BudgetDetails({Key? key}) : super(key: key);

   void _budgetEdit(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 0,
        backgroundColor: AppColors.darkGreyColor,
        context: ctx,
        builder: (_) {
          return const BudgetEditSheet();
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    BodyText(
                        color: AppColors.whiteColor,
                        size: 20,
                        text: 'Family',
                        weight: FontWeight.w600),
                    GestureDetector(
                      onTap: () => _budgetEdit(context),
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.lightBlueColor,
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.06),
                Row(
                  children: [
                    BodyText(
                        color: AppColors.whiteColor,
                        size: 25,
                        text: '\$ 200.00 spent',
                        weight: FontWeight.w400),
                  ],
                ),
                const SizedBox(height: 10),
                const ChartBar(),
                const SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        // padding: const EdgeInsets.all(10),
                        height: size.height * 0.05,
                        width: size.height * 0.17,
                        decoration: BoxDecoration(
                          color: AppColors.lightBlueColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                            child: BodyText(
                                color: AppColors.whiteColor,
                                size: 16,
                                text: "\$1000/month",
                                weight: FontWeight.w400))),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
              ]),
            ),
            const BudgetDetailsBody()
          ],
        ),
      ),
    );
  }
}
