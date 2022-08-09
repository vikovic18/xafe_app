import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/drop_down_button.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/utils/colors.dart';

class AddCategory extends ConsumerStatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategory> {
  final TextEditingController nameController = TextEditingController();

  String dropdownvalue = 'Choose Category emoji';

  var items = [
    'Choose Category emoji',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void addCategory(context) async {
    String name = nameController.text.trim();

    await ref
        .read(categoryControllerProvider)
        .addCategory(context, name, dropdownvalue);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                  text: 'Add a spending category',
                  weight: FontWeight.w400),
              SizedBox(
                height: size.height * 0.04,
              ),
              ReusableTextField(
                controller: nameController,
                hintText: 'Enter category name',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 10),
              CustomizedDropDownButton(
                  dropdownvalue: dropdownvalue, items: items)
              // ReusableTextField(
              //     controller: emoji,
              //     hintText: 'Choose category emoji',
              //     keyboardType: TextInputType.none,
              //     suffix: const Icon(Icons.arrow_downward_outlined)),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(
              onPressed: () => addCategory(context), text: 'Create Category')),
    );
  }
}
