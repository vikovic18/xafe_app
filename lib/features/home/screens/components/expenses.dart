import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/custom_divider.dart';
import 'package:xafe/utils/colors.dart';


class Expenses extends StatelessWidget {
  const Expenses({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
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
                                  const Icon(Icons.food_bank),
                                  const SizedBox(width: 12),
                                  SizedBox(
                                    width: size.height*0.15,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: BodyText(
                                          color: AppColors.blackColor,
                                          size: 18,
                                          text: 'Bill Payments',
                                          weight: FontWeight.w500),
                                    ),
                                  )
                                ],
                              ),
                              BodyText(
                                  color: AppColors.blackColor,
                                  size: 16,
                                  text: '\$500.00',
                                  weight: FontWeight.w400)
                            ],
                          ),
                          SizedBox(height: size.height * 0.05)
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}




