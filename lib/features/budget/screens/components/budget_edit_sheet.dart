import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/bottom_navigation_bar.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/budget/screens/components/add_budget_expenses.dart';
import 'package:xafe/features/budget/screens/components/edit_budget.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/utils/delete_error_alert.dart';
import 'package:xafe/utils/snackbar.dart';

class BudgetEditSheet extends ConsumerStatefulWidget {
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

  @override
  _BudgetEditSheetState createState() => _BudgetEditSheetState();
}

class _BudgetEditSheetState extends ConsumerState<BudgetEditSheet> {
  bool _isLoading = false;
  void _loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _deleteBudget(context) async {
    final result = await showCustomDeleteDialog(context);
    if (result == true) {
      _loading();
      await ref
          .read(budgetControllerProvider)
          .deleteBudget(widget.id)
          .then((status) => {
                if (status.isSuccess)
                  _loading(),
                  showSnackBar(
                      context: context, content: 'Deleted Successfully')
              })
          .then((_) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const CustomizedBottomNavigationBar()),
                )
              })
          .catchError((error) {
        showSnackBar(context: context, content: error.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return !_isLoading ? Container(
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
                icon: Icons.monetization_on_rounded,
                color: const Color(0XFFFF8514),
                title: 'Add an Expense',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddBudgetExpenses(
                            budgetId: widget.id, budgetAmount: widget.amount)),
                  );
                }),
            EditOptions(
                icon: Icons.swap_horiz,
                color: const Color(0XFF0C50FF),
                title: 'Edit Budget',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditBudget(
                              id: widget.id,
                              name: widget.name,
                              amount: widget.amount,
                              interval: widget.interval,
                            )),
                  );
                }),
            EditOptions(
                icon: Icons.delete_outline,
                color: const Color(0XFFF62E21),
                title: 'Delete Budget',
                onPressed: () => _deleteBudget(context))
          ],
        )): const Loader();
  }
}

//EditOptionsWidget

class EditOptions extends StatelessWidget {
  const EditOptions(
      {Key? key,
      required this.icon,
      required this.title,
      required this.color,
      required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: color),
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
