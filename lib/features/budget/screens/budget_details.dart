// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/chart_bar.dart';
import 'package:xafe/common_widgets/error.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/budget/screens/components/budget_expenses.dart';
import 'package:xafe/features/budget/screens/components/budget_edit_sheet.dart';
import 'package:xafe/utils/colors.dart';

class BudgetDetails extends ConsumerStatefulWidget {
  static const routeName = '/budget-details';
  const BudgetDetails(
      {Key? key,
      required this.name,
      required this.id,
      required this.amount,
      required this.interval})
      : super(key: key);

  final String name;
  final String id;
  final double amount;
  final String interval;

  @override
  _BudgetDetailsState createState() => _BudgetDetailsState();
}

class _BudgetDetailsState extends ConsumerState<BudgetDetails> {
  void _budgetEdit(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 0,
        backgroundColor: AppColors.darkGreyColor,
        context: ctx,
        builder: (_) {
          return BudgetEditSheet(
            id: widget.id,
            name: widget.name,
            amount: widget.amount,
            interval: widget.interval,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final budgetList = ref.watch(budgetExpensesProvider(widget.id));
   
    return Scaffold(
        backgroundColor: AppColors.blueColor,
        body: SafeArea(
            child: budgetList.when(
                data: (expenses) {
                  double sum = 0;
                  for (var element in expenses) {
                    double total = element.amount!;
                    sum += total;
                  }
                  return Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                                  text: widget.name,
                                  weight: FontWeight.w600),
                              GestureDetector(
                                onTap: () => _budgetEdit(context),
                                child: const CircleAvatar(
                                  radius: 24,
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
                                  text: '\$ ${sum.toStringAsFixed(0)} spent',
                                  weight: FontWeight.w400),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ChartBar(
                            baseColor: AppColors.lightBlueColor,
                            overflowColor: AppColors.whiteColor,
                            totalPercent: sum / widget.amount,
                          ),
                          const SizedBox(height: 17),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  height: size.height * 0.05,
                                  width: size.height * 0.17,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightBlueColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                      child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: BodyText(
                                        color: AppColors.whiteColor,
                                        size: 16,
                                        text:
                                            "\$${widget.amount.toStringAsFixed(0)}/${widget.interval.toLowerCase()}",
                                        weight: FontWeight.w400),
                                  ))),
                            ],
                          ),
                          SizedBox(height: size.height * 0.05),
                        ]),
                      ),
                      BudgetExpenses(budgetId: widget.id)
                    ],
                  );
                },
                error: (err, trace) {
                  return ErrorScreen(error: err.toString());
                },
                loading: () => const Loader())));
  }
}
