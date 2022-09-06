import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/error.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/home/controller/expenses_controller.dart';
import 'package:xafe/features/home/screens/components/expense_edit_sheet.dart';
import 'package:xafe/utils/colors.dart';

class Summary extends ConsumerWidget {
  const Summary({Key? key}) : super(key: key);

  // double sum = 0;

  void _edit(BuildContext ctx) {
    showModalBottomSheet(
        elevation: 0,
        backgroundColor: AppColors.darkGreyColor,
        context: ctx,
        builder: (_) {
          return const EditSheet();
        });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final allBudgetList = ref.watch(allTotalBudgetExpensesProvider);
    final allExpensesList = ref.watch(allExpensesControllerProvider);
    final income = ref.watch(incomeControllerProvider);
    return Container(
      height: size.height * 0.47,
      padding: const EdgeInsets.only(top: 24, left: 20, right: 20),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.blueColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // SizedBox(
              //   width: size.height * 0.19,
              //   height: size.height * 0.08,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //           primary: AppColors.lightBlueColor,
              //           shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(15))),
              //       onPressed: () {},
              //       child: Row(children: [
              //         const BodyText(
              //             color: AppColors.whiteColor,
              //             size: 14,
              //             text: 'This Week',
              //             weight: FontWeight.w400),
              //         SizedBox(width: 2),
              //         Icon(Icons.expand_more)
              //       ])),
              // ),
              GestureDetector(
                onTap: () {
                  _edit(context);
                },
                child: CircleAvatar(
                    radius: size.height * 0.04,
                    backgroundColor: AppColors.whiteColor,
                    child: const Icon(Icons.edit_outlined)),
              )
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BoxContainer(height: size.height * 0.12),
                  SizedBox(width: size.height * 0.07),
                  BoxContainer(height: size.height * 0.20)
                ],
              ),
              const SizedBox(height: 10),
              allBudgetList.when(
                  data: (allBudgetExpenses) {
                    double sum = 0;
                    for (var element in allBudgetExpenses) {
                      double total = element.amount!;
                      sum += total;
                    }
                    return allExpensesList.when(
                        data: (allExpenses) {
                          for (var element in allExpenses) {
                            double total = element.amount!;
                            sum += total;
                          }
                          return income.when(
                              data: (allincome) {
                                double finalIncome = 0;
                                for (var element in allincome) {
                                  finalIncome = element.income!;
                                }
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextOptions(
                                        title: 'Expenses',
                                        amount: '\$${sum.toStringAsFixed(0)}'),
                                    SizedBox(width: size.height * 0.07),
                                    TextOptions(
                                        title: 'Income',
                                        amount: finalIncome.toStringAsFixed(2))
                                  ],
                                );
                              },
                              error: (err, trace) {
                                return ErrorScreen(error: err.toString());
                              },
                              loading: () => const Loader());
                        },
                        error: (err, trace) {
                          return ErrorScreen(error: err.toString());
                        },
                        loading: () => const Loader());
                  },
                  error: (err, trace) {
                    return ErrorScreen(error: err.toString());
                  },
                  loading: () => const Loader()),
              SizedBox(height: size.height * 0.02)
            ],
          )
        ],
      ),
    );
  }
}

class BoxContainer extends StatelessWidget {
  const BoxContainer({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: height,
      width: size.height * 0.10,
      decoration: BoxDecoration(
          color: AppColors.whiteColor, borderRadius: BorderRadius.circular(12)),
    );
  }
}

class TextOptions extends StatelessWidget {
  const TextOptions({Key? key, required this.title, required this.amount})
      : super(key: key);

  final String title;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BodyText(
          color: AppColors.whiteColor,
          size: 14,
          text: title,
          weight: FontWeight.w600),
      const SizedBox(height: 2),
      BodyText(
          color: AppColors.whiteColor,
          size: 24,
          text: amount,
          weight: FontWeight.w700)
    ]);
  }
}
