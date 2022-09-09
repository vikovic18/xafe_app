import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/error.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/models/category.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/utils/snackbar.dart';

class AddBudgetExpenses extends ConsumerStatefulWidget {
  const AddBudgetExpenses(
      {Key? key, required this.budgetId, required this.budgetAmount})
      : super(key: key);

  final String budgetId;
  final double budgetAmount;

  @override
  _AddBudgetExpensesState createState() => _AddBudgetExpensesState();
}

class _AddBudgetExpensesState extends ConsumerState<AddBudgetExpenses> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  bool _isLoading = false;
  void _loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  String? dropdownvalue;

  

  String? categoryId;

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    nameController.dispose();
    dateController.dispose();
  }

  void _addBudgetExpenses() async {
    String name = nameController.text.trim();
    String amount = amountController.text.trim();
    String dateTime = dateController.text.trim();
    DateTime formattedDateTime = DateFormat('dd/MM/yy').parse(dateTime);
    Timestamp timeStamp = Timestamp.fromDate(formattedDateTime);
    DateTime newDateTime = timeStamp.toDate();
    String? categoryEmoji;
    List<CategoryModel> categoryList =
        await ref.read(categoryControllerProvider).getAllCategories();
     for (var element in categoryList) {
      if (element.name == dropdownvalue) {
        categoryId = element.documentId;
        categoryEmoji = element.emoji!;
      }
    }
    double checkExpensesAmount = await ref
        .read(budgetControllerProvider)
        .getBudgetExpensesAmount(widget.budgetId);
    double totalBudgetAmount = double.parse(amount) + checkExpensesAmount;
    if (totalBudgetAmount <= widget.budgetAmount) {
      _loading();
      await ref
          .read(budgetControllerProvider)
          .addBudgetExpenses(name, double.parse(amount), categoryId!,
              widget.budgetId, newDateTime, categoryEmoji!)
          .then((status) => {
                if (status.isSuccess)
                  {
                    showSnackBar(
                        context: context, content: 'Added Successfully')
                  }
              })
          .catchError((error) {
        showSnackBar(context: context, content: error.toString());
      });
      _loading();
    } else {
      showSnackBar(
          context: context, content: "You can't spend more than your budget");
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final categoryList = ref.watch(allCategoriesProvider);
    return Scaffold(
        body: SafeArea(
            child: !_isLoading
                ? SingleChildScrollView(
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
                              text: 'Add an expense',
                              weight: FontWeight.w400),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                          SingleChildScrollView(
                            child: Column(children: [
                              Container(
                                  height: size.height * 0.08,
                                  margin: const EdgeInsets.only(right: 20),
                                  padding: const EdgeInsets.only(left: 20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.textFieldColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: AppColors.greyColor)),
                                  child: categoryList.when(
                                      data: (allCategories) {
                                        List<String> names = [];
                                        for (var element in allCategories) {
                                          names.add(element.name!);
                                        }
                                        return DropdownButton(
                                            hint: const BodyText(
                                              color: AppColors.blackColor,
                                              size: 14,
                                              weight: FontWeight.w400,
                                              text: 'please choose a category',
                                            ),
                                            style: const TextStyle(
                                                fontFamily: 'Euclid',
                                                fontSize: 14,
                                                color: AppColors.blackColor),
                                            value: dropdownvalue,
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                            ),
                                            items: names.map((String value) {
                                              return DropdownMenuItem(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                dropdownvalue = newValue!;
                                              });
                                            });
                                      },
                                      error: (err, trace) {
                                        return ErrorScreen(
                                            error: err.toString());
                                      },
                                      loading: () => const Loader())),
                              const SizedBox(height: 10),
                              ReusableTextField(
                                controller: amountController,
                                hintText: 'expense amount',
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(height: 10),
                              ReusableTextField(
                                  controller: nameController,
                                  hintText: 'expense name',
                                  keyboardType: TextInputType.name),
                              const SizedBox(height: 10),
                              ReusableTextField(
                                controller: dateController,
                                hintText: 'date (dd/mm/yy)',
                                keyboardType: TextInputType.name,
                              )
                            ]),
                          )
                        ],
                      ),
                    ),
                  )
                : const Loader()),
        bottomNavigationBar: !_isLoading
            ? Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: ButtonText(
                    onPressed: _addBudgetExpenses, text: 'Add Expense'))
            : const SizedBox());
  }
}
