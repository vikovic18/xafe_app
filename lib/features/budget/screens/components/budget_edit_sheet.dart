import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/bottom_navigation_bar.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/budget/screens/components/add_budget_expenses.dart';
import 'package:xafe/features/budget/screens/components/edit_budget.dart';
import 'package:xafe/utils/colors.dart';

class BudgetEditSheet extends ConsumerWidget {
  const BudgetEditSheet(
      {Key? key,
      required this.id,
      required this.name,
      required this.amount,
      required this.interval})
      : super(key: key);

  final String id;
  final String name;
  final double amount;
  final String interval;

  void _deleteBudget(context, WidgetRef ref) async {
    await ref
        .read(budgetControllerProvider)
        .deleteBudget(context, id)
        .then((_) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CustomizedBottomNavigationBar()),
              )
            });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        builder: (context) => AddBudgetExpenses(
                              budgetId: id,
                            )),
                  );
                }),
            EditOptions(
                icon: Icons.paste_outlined,
                title: 'Edit Budget',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditBudget(
                              id: id,
                              name: name,
                              amount: amount,
                              interval: interval,
                            )),
                  );
                }),
            EditOptions(
                icon: Icons.panorama_outlined,
                title: 'Delete Budget',
                onPressed: () => _deleteBudget(context, ref))
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
