import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/chart_bar.dart';
import 'package:xafe/common_widgets/error.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/budget/screens/budget_details.dart';
import 'package:xafe/models/budget.dart';
import 'package:xafe/utils/colors.dart';

class BudgetBody extends ConsumerWidget {
  const BudgetBody({Key? key, required this.budget}) : super(key: key);

  final BudgetModel budget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final budgetList = ref.watch(budgetExpensesProvider(budget.documentId!));
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, BudgetDetails.routeName, arguments: {
          "name": budget.name,
          "id": budget.documentId,
          "amount": budget.amount,
          "interval": budget.interval,
        });
      },
      child: Container(
        height: size.height * 0.14,
        width: size.height * 0.23,
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(15)),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.height * 0.15,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: BodyText(
                        color: AppColors.darkGreyColor,
                        size: 16,
                        text: budget.name!,
                        weight: FontWeight.w400),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: BodyText(
                      color: AppColors.blackColor,
                      size: 20,
                      text:
                          '\$${budget.amount!.toStringAsFixed(0)}/${budget.interval!.toLowerCase()}',
                      weight: FontWeight.w400),
                ),
                const SizedBox(height: 12),
                budgetList.when(
                    data: (expenses) {
                      double sum = 0;
                      for (var element in expenses) {
                        double total = element.amount!;
                        sum += total;
                      }
                      return ChartBar(
                          totalPercent: sum / budget.amount!,
                          baseColor: AppColors.textFieldColor,
                          overflowColor: AppColors.lightBlueColor);
                    },
                    error: (err, trace) {
                      return ErrorScreen(error: err.toString());
                    },
                    loading: () => const Loader())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
