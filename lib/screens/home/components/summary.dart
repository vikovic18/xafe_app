import 'package:flutter/material.dart';
import 'package:xafe/screens/home/components/expense_edit_sheet.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size.height);
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
              SizedBox(
                width: size.height * 0.19,
                height: size.height * 0.08,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColors.lightBlueColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    onPressed: () {},
                    child: Row(children: [
                      const BodyText(
                          color: AppColors.whiteColor,
                          size: 14,
                          text: 'This Week',
                          weight: FontWeight.w400),
                      SizedBox(width: 2),
                      Icon(Icons.expand_more)
                    ])),
              ),
              GestureDetector(
                onTap: (){
                  _edit(context);
                },
                child: CircleAvatar(
                    radius: size.height * 0.04,
                    backgroundColor: AppColors.whiteColor,
                    child: Icon(Icons.edit_outlined)),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TextOptions(title: 'Expenses', amount: '\$4,750.00'),
                  SizedBox(width: size.height * 0.07),
                  const TextOptions(title: 'Income', amount: '\$9,500.00')
                ],
              )
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
