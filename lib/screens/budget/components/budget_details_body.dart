import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/custom_divider.dart';

class BudgetDetailsBody extends StatelessWidget {
  const BudgetDetailsBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
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
                                      BodyText(
                                          color: AppColors.blackColor,
                                          size: 20,
                                          text: 'Celery',
                                          weight: FontWeight.w400),
                                      BodyText(
                                          color: AppColors.greyColor,
                                          size: 14,
                                          text: '03/12/20',
                                          weight: FontWeight.w400)
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                width: size.height*0.07,
                                height: size.height*0.04,
                                decoration: BoxDecoration(
                                    color: AppColors.textFieldColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Center(
                                  child: BodyText(
                                      color: AppColors.blackColor,
                                      size: 16,
                                      text: '\$14.99',
                                      weight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                           SizedBox(height: size.height * 0.03)
                        ],
                      );
                    }),
              )
            ],
          )),
    );
  }
}
