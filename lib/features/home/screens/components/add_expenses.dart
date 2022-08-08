import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/utils/colors.dart';


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
                  text: 'Add an expense',
                  weight: FontWeight.w400),
              SizedBox(
                height: size.height * 0.04,
              ),
              ReusableTextField(controller: amount, hintText: 'expense amount', keyboardType: TextInputType.number,),
              const SizedBox(height: 10),
              ReusableTextField(
                  keyboardType: TextInputType.none,
                  controller: category,
                  hintText: 'Select category',
                  suffix: Icon(Icons.arrow_downward_outlined)),
              const SizedBox(height: 10),
              ReusableTextField(controller: name, hintText: 'expense name', keyboardType: TextInputType.name),
              const SizedBox(height: 10),
              ReusableTextField(controller: date, hintText: 'date (dd/mm/yy', keyboardType: TextInputType.datetime,)
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(onPressed: () {}, text: 'Add Expense')),
    );
  }
}
