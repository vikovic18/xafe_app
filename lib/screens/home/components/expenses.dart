import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/custom_divider.dart';

class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.3795,
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
          Expanded(
            child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.food_bank),
                                BodyText(
                                    color: AppColors.blackColor,
                                    size: 18,
                                    text: 'Bill Payments',
                                    weight: FontWeight.w400)
                              ],
                            ),
                            BodyText(
                                color: AppColors.blackColor,
                                size: 16,
                                text: '\$500.00',
                                weight: FontWeight.w400)
                          ],
                        ),
                        SizedBox(height: size.height * 0.03)
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}




