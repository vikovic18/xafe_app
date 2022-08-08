import 'package:flutter/material.dart';
import 'package:xafe/screens/budget/components/edit_budget.dart';
import 'package:xafe/screens/home/components/add_expenses.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/custom_divider.dart';

class BudgetEditSheet extends StatelessWidget {
  const BudgetEditSheet({Key? key}) : super(key: key);

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
                title: 'Edit Budget',
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditBudget()),
                  );
                }),
            EditOptions(
                icon: Icons.panorama_outlined,
                title: 'Delete Budget',
                onPressed: () {
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
