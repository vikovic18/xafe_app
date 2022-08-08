import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/features/budget/screens/components/add_budget.dart';
import 'package:xafe/features/categories/screens/components/add_categories.dart';
import 'package:xafe/features/home/screens/components/add_expenses.dart';

import 'package:xafe/utils/colors.dart';


class EditSheet extends StatelessWidget {
  const EditSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.3795,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20, left: 20),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.height * 0.05),
                topRight: Radius.circular(size.height * 0.05))),
        child: Column(
          children: [
            const CustomDivider(),
            SizedBox(
              height: size.height * 0.03,
            ),
            EditOptions(
                icon: Icons.party_mode,
                title: 'Add an Expense',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddExpenses()),
                  );
                }),
            EditOptions(
                icon: Icons.paste_outlined,
                title: 'Create a budget',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddBudget()),
                  );
                }),
            EditOptions(
                icon: Icons.panorama_outlined,
                title: 'Add a Spending Category',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddCategory()),
                  );
                })
          ],
        ));
  }
}

class EditOptions extends StatelessWidget {
  const EditOptions(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 15),
          BodyText(
              color: AppColors.blackColor,
              size: 18,
              text: title,
              weight: FontWeight.w400),
          SizedBox(
            height: size.height * 0.08,
          ),
        ],
      ),
    );
  }
}
