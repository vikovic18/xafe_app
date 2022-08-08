import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/button.dart';
import 'package:xafe/widgets/reusable_textfield.dart';

class AddBudget extends StatefulWidget {
  const AddBudget({Key? key}) : super(key: key);

  @override
  State<AddBudget> createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController interval = TextEditingController();
  final TextEditingController name = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    amount.dispose();
    name.dispose();
    interval.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.darkGreyColor,
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              const BodyText(
                  color: AppColors.blackColor,
                  size: 24,
                  text: 'Create a budget',
                  weight: FontWeight.w400),
              SizedBox(
                height: size.height * 0.04,
              ),
              ReusableTextField(controller: name, hintText: 'Budget name'),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              ReusableTextField(controller: amount, hintText: 'Budget amount'),
              const SizedBox(height: 10),
              ReusableTextField(
                  controller: interval,
                  hintText: 'Choose interval',
                  suffix: const Icon(Icons.arrow_downward_outlined)),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(onPressed: () {}, text: 'Create Budget')),
    );
  }
}
