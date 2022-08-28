import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/utils/colors.dart';

class AddBudget extends ConsumerStatefulWidget {
  const AddBudget({Key? key}) : super(key: key);

  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends ConsumerState<AddBudget> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String dropdownvalue = 'Choose an interval';

  var items = [
    'Choose an interval',
    'Day',
    'Month',
    'Year',
  ];

  void _addBudget(context) async {
    String name = nameController.text.trim();
    String amountText = amountController.text.trim();
    String amount = amountText.replaceAll(",", "");
    await ref
        .read(budgetControllerProvider)
        .addBudget(context, name, double.parse(amount), dropdownvalue);
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    nameController.dispose();
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
              ReusableTextField(
                controller: nameController,
                hintText: 'Budget name',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              ReusableTextField(
                controller: amountController,
                hintText: 'Budget amount',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Container(
                height: size.height * 0.08,
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.only(left: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.textFieldColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColors.greyColor)),
                child: DropdownButton(
                    style: const TextStyle(
                        fontFamily: 'Euclid',
                        fontSize: 14,
                        color: AppColors.blackColor),
                    value: dropdownvalue,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: items.map((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(
              onPressed: () => _addBudget(context), text: 'Create Budget')),
    );
  }
}
