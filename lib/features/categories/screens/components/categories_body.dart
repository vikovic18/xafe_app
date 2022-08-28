import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/models/category.dart';
import 'package:xafe/utils/colors.dart';

class CategoriesBody extends ConsumerWidget {
  const CategoriesBody({Key? key, required this.categories}) : super(key: key);

  final Iterable<CategoryModel> categories;

  void deleteCategory(context, documentId, WidgetRef ref) async {
    await ref
        .read(categoryControllerProvider)
        .deleteCategory(context, documentId);
  }

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
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Center(child: CustomDivider()),
              SizedBox(
                height: size.height * 0.03,
              ),
              BodyText(
                  color: AppColors.blackColor,
                  size: 16,
                  text: '${categories.length} Spending Categories',
                  weight: FontWeight.w400),
              SizedBox(height: size.height * 0.03),
              Expanded(
                child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      final category = categories.elementAt(index);
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.food_bank),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: size.height * 0.15,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: BodyText(
                                              color: AppColors.blackColor,
                                              size: 16,
                                              text: category.name!,
                                              weight: FontWeight.w600),
                                        ),
                                      ),
                                      BodyText(
                                          color: AppColors.greyColor,
                                          size: 14,
                                          text: DateFormat('dd/MM/yy')
                                              .format(category.dateTime!),
                                          // category.dateTime!.toString(),
                                          weight: FontWeight.w400)
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: size.height * 0.12,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                    color: AppColors.lightRedColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: GestureDetector(
                                  onTap: () => deleteCategory(
                                      context, category.documentId, ref),
                                  child: const Center(
                                    child: BodyText(
                                        color: AppColors.yellowColor,
                                        size: 16,
                                        text: 'remove',
                                        weight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height * 0.05)
                        ],
                      );
                    }),
              ),
            ])));
  }
}
