import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/home/controller/expenses_controller.dart';
import 'package:xafe/models/expenses.dart';
import 'package:xafe/utils/colors.dart';

class Expenses extends ConsumerWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.height * 0.05),
                topRight: Radius.circular(size.height * 0.05))),
        child: Column(
          children: [
            const CustomDivider(),
            SizedBox(height: size.height * 0.05),
            StreamBuilder(
                stream:
                    ref.read(expensesControllerProvider).allExpenses(),
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  final allExpenses = snapshot.data as Iterable<ExpensesModel>;
                  return Expanded(
                    child: ListView.builder(
                        itemCount: allExpenses.length,
                        itemBuilder: (BuildContext context, int index) {
                          final expenses = allExpenses.elementAt(index);
                          return Container(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.food_bank),
                                        const SizedBox(width: 12),
                                        SizedBox(
                                          width: size.height * 0.15,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: BodyText(
                                                color: AppColors.blackColor,
                                                size: 18,
                                                text: expenses.name!,
                                                weight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    ),
                                    BodyText(
                                        color: AppColors.blackColor,
                                        size: 16,
                                        text: '\$${expenses.amount}',
                                        weight: FontWeight.w400)
                                  ],
                                ),
                                SizedBox(height: size.height * 0.05)
                              ],
                            ),
                          );
                        }),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
