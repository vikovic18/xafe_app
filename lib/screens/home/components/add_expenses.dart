import 'package:flutter/material.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/widgets/body_text.dart';
import 'package:xafe/widgets/reusable_textfield.dart';

class AddExpenses extends StatefulWidget {
  const AddExpenses({Key? key}) : super(key: key);

  @override
  State<AddExpenses> createState() => _AddExpensesState();
}

class _AddExpensesState extends State<AddExpenses> {
  final TextEditingController amount = TextEditingController();
  final TextEditingController category = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController date = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    amount.dispose();
    category.dispose();
    name.dispose();
    date.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: AppColors.darkGreyColor,
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              const BodyText(
                  color: AppColors.blackColor,
                  size: 24,
                  text: 'Add an expense',
                  weight: FontWeight.w400),
              SizedBox(
                height: size.height * 0.04,
              ),
              ReusableTextField(controller: amount, hintText: 'expense amount'),
              const SizedBox(height: 10),
              ReusableTextField(
                  controller: category,
                  hintText: 'Select category',
                  suffix: Icon(Icons.arrow_downward_outlined)),
              const SizedBox(height: 10),
              ReusableTextField(controller: name, hintText: 'expense name'),
              const SizedBox(height: 10),
              ReusableTextField(controller: date, hintText: 'date (dd/mm/yy')
            ],
          ),
        ),
      ),
    );
  }
}
