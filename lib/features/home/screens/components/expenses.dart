import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/common_widgets/error.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/features/home/controller/expenses_controller.dart';
import 'package:xafe/models/emoji.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/utils/snackbar.dart';

class Expenses extends ConsumerWidget {
  Expenses({Key? key}) : super(key: key);

  Icon? emojiIcon;

  void _deleteExpenses(
      String documentId, WidgetRef ref, BuildContext context) async {
    await ref
        .read(expensesControllerProvider)
        .deleteExpenses(documentId)
        .then((status) => {
              if (status.isSuccess)
                {
                  showSnackBar(
                      context: context, content: 'Deleted successfully')
                }
            })
        .catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final expensesList = ref.watch(allExpensesControllerProvider);
    List<EmojiModel> emojis = ref.watch(categoryControllerProvider).emojis;
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: size.height * 0.02),
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(size.height * 0.05),
                topRight: Radius.circular(size.height * 0.05))),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height * 0.35,
            child: Column(
              children: [
                const CustomDivider(),
                SizedBox(height: size.height * 0.05),
                expensesList.when(
                    data: (allExpenses) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: allExpenses.length,
                            itemBuilder: (BuildContext context, int index) {
                              final expenses = allExpenses.elementAt(index);
                              for (var element in emojis) {
                                if (expenses.categoryEmoji == element.emoji) {
                                  emojiIcon = element.icon;
                                }
                              }
                              return Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            emojiIcon!,
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: size.height * 0.15,
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: BodyText(
                                                    color: AppColors.blackColor,
                                                    size: 18,
                                                    text: expenses.name!,
                                                    weight: FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            BodyText(
                                                color: AppColors.blackColor,
                                                size: 16,
                                                text: '\$${expenses.amount}',
                                                weight: FontWeight.w400),
                                            const SizedBox(width: 5),
                                            InkWell(
                                              onTap: () {
                                                _deleteExpenses(
                                                    expenses.documentId!,
                                                    ref,
                                                    context);
                                              },
                                              child: const Icon(
                                                Icons.delete_outline,
                                                color: Color(0XFFF62E21),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: size.height * 0.05)
                                  ],
                                ),
                              );
                            }),
                      );
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
