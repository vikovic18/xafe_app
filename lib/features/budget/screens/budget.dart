import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/budget/screens/components/budget_body.dart';
import 'package:xafe/models/budget.dart';

import 'package:xafe/utils/colors.dart';

class Budget extends ConsumerWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                SizedBox(height: size.height * 0.05),
                StreamBuilder(
                    stream:
                        ref.read(budgetControllerProvider).allBudget(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader();
                      }
                      final allBudget = snapshot.data as Iterable<BudgetModel>;
                      return Expanded(
                        child: GridView.builder(
                            itemCount: allBudget.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3 / 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 10),
                            itemBuilder: (BuildContext ctx, int index) {
                              final budget = allBudget.elementAt(index);
                              return BudgetBody(budget: budget);
                            }),
                      );
                    }))
              ],
            ),
          ),
        ));
  }
}
