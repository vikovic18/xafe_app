import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/utils/colors.dart';


class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  final TextEditingController name = TextEditingController();
  final TextEditingController emoji = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    emoji.dispose();
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
              ReusableTextField(controller: name, hintText: 'Enter category name', keyboardType: TextInputType.name,),
              const SizedBox(height: 10),
              ReusableTextField(
                  controller: emoji,
                  hintText: 'Choose category emoji',
                  keyboardType: TextInputType.none,
                  suffix: const Icon(Icons.arrow_downward_outlined)),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(onPressed: () {}, text: 'Create Category')),
    );
  }
}
