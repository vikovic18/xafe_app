import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/budget/controller/budget_controller.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/models/category.dart';
import 'package:xafe/utils/colors.dart';

class AddBudgetExpenses extends ConsumerStatefulWidget {
  const AddBudgetExpenses({Key? key, required this.budgetId}) : super(key: key);

  final String budgetId;

  @override
  _AddBudgetExpensesState createState() => _AddBudgetExpensesState();
}

class _AddBudgetExpensesState extends ConsumerState<AddBudgetExpenses> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String? dropdownvalue;
  var isInit = true;

  String? categoryId;

  List<String> names = ['Please Choose a Category'];

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    nameController.dispose();
    dateController.dispose();
  }

  // Future<List<CategoryModel>> selectCategory(context) async {
  //   return await ref.read(categoryControllerProvider).getAllCategories();
  // }

  void addBudgetExpenses(context) async {
    String name = nameController.text.trim();
    String amount = amountController.text.trim();
    String dateTime = dateController.text.trim();
    DateTime formattedDateTime = DateFormat('dd/MM/yy').parse(dateTime);
    Timestamp timeStamp = Timestamp.fromDate(formattedDateTime);
    DateTime newDateTime = timeStamp.toDate();
    List<CategoryModel> categoryList =
        await ref.read(categoryControllerProvider).getAllCategories();
    for (var element in categoryList) {
      if (element.name == dropdownvalue) {
        categoryId = element.documentId;
      }
    }
    await ref.read(budgetControllerProvider).addBudgetExpenses(context, name,
        double.parse(amount), categoryId!, widget.budgetId, newDateTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
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
                        border: Border.all(color: AppColors.greyColor)),
                    child: FutureBuilder(
                      future: ref
                          .read(categoryControllerProvider)
                          .getAllCategories(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Loader();
                        }
                        if (snapshot.hasData) {
                          List<String> name = ['please choose a category'];
                          final categories =
                              snapshot.data as List<CategoryModel>;
                          for (var element in categories) {
                            name.add(element.name!);
                          }
                          names = name;
                          return DropdownButton(
                              hint: const BodyText(
                                color: AppColors.blackColor,
                                size: 14,
                                weight: FontWeight.w400,
                                text: 'add a category',
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
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ReusableTextField(
                    controller: amountController,
                    hintText: 'expense amount',
                    keyboardType: TextInputType.name,
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
      )),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: ButtonText(
              onPressed: () => addBudgetExpenses(context),
              text: 'Add Expense')),
    );
  }
}
