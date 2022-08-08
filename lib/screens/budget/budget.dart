import 'package:flutter/material.dart';
import 'package:xafe/screens/budget/components/budget_body.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';

class Budget extends StatelessWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.blueColor,
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.laptop_windows_rounded,
                      size: 24,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    BodyText(
                        color: AppColors.whiteColor,
                        size: 24,
                        text: 'Budgets',
                        weight: FontWeight.w600)
                  ],
                ),
                SizedBox(height: size.height*0.05),
                Expanded(
                  child: GridView.builder(
                    itemCount: 5,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 10),
                      itemBuilder: (BuildContext ctx, int index) {
                        return const BudgetBody();
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
