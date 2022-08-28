import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/models/budget_expenses.dart';
import 'package:xafe/utils/colors.dart';


class BudgetExpenses extends ConsumerWidget {
  const BudgetExpenses({Key? key, required this.budgetId}) : super(key: key);

  final String budgetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.height * 0.05),
                  topRight: Radius.circular(size.height * 0.05))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: CustomDivider()),
              SizedBox(
                height: size.height * 0.03,
              ),
              const BodyText(
                  color: AppColors.blackColor,
                  size: 16,
                  text: 'Expense History',
                  weight: FontWeight.w400),
              SizedBox(height: size.height * 0.03),
              StreamBuilder(
                    stream: 
                        ref.read(budgetControllerProvider).allBudgetExpenses(budgetId),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader();
                      }
                      final allBudgetExpenses = snapshot.data as Iterable<BudgetExpensesModel>;
              return Expanded(
                child: ListView.builder(
                    itemCount: allBudgetExpenses.length,
                    itemBuilder: (BuildContext context, int index) {
                      final budgetExpense = allBudgetExpenses.elementAt(index);
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.food_bank),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: BodyText(
                                            color: AppColors.blackColor,
                                            size: 16,
                                            text: budgetExpense.name!,
                                            weight: FontWeight.w400),
                                      ),
                                      BodyText(
                                          color: AppColors.greyColor,
                                          size: 14,
                                          text: DateFormat('dd/MM/yy').format(budgetExpense.dateTime!),
                                          weight: FontWeight.w400)
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: size.height*0.09,
                                height: size.height*0.04,
                                decoration: BoxDecoration(
                                    color: AppColors.textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: BodyText(
                                        color: AppColors.blackColor,
                                        size: 16,
                                        text: '\$${budgetExpense.amount!.toStringAsFixed(0)}',
                                        weight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                           SizedBox(height: size.height * 0.03)
                        ],
                      );
                    }),
              );
              }))
            ],
          )),
    );
  }
}
