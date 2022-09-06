import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/bottom_navigation_bar.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/utils/snackbar.dart';

class EditBudget extends ConsumerStatefulWidget {
  const EditBudget(
      {Key? key,
      required this.id,
      required this.name,
      required this.amount,
      required this.interval})
      : super(key: key);

  final String id;
  final String name;
  final double amount;
  final String interval;

  @override
  _EditBudgetState createState() => _EditBudgetState();
}

class _EditBudgetState extends ConsumerState<EditBudget> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interval = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String dropdownvalue = '';

  bool _isLoading = false;
  void _loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  var items = [
    'Day',
    'Month',
    'Year',
  ];

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    nameController.dispose();
    interval.dispose();
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    amountController.text = widget.amount.toStringAsFixed(0);
  }

  void _editBudget() async {
    String name = nameController.text.trim();
    String amount = amountController.text.trim();
    String budgetInterval =
        dropdownvalue == '' ? widget.interval : dropdownvalue;
    _loading();
    await ref
        .read(budgetControllerProvider)
        .editBudget(widget.id, name, double.parse(amount), budgetInterval)
        .then((status) => {
              if (status.isSuccess)
                {
                  _loading(),
                  showSnackBar(
                      context: context, content: 'Updated successfully')
                }
            })
        .then((_) => Navigator.pushNamed(
              context,
              CustomizedBottomNavigationBar.routeName,
            ))
        .catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: !_isLoading ? Container(
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
                  text: 'Edit family budget',
                  weight: FontWeight.w400),
              SizedBox(
                height: size.height * 0.04,
              ),
              ReusableTextField(
                controller: nameController,
                hintText: '',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              ReusableTextField(
                controller: amountController,
                hintText: '',
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
                    value:
                        dropdownvalue == '' ? widget.interval : dropdownvalue,
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
        ) : const Loader()
      ),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child:  ButtonText(
                  onPressed: () => _editBudget(), text: 'Create Budget')
              ),
    );
  }
}
