import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/button.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/common_widgets/reusable_textfield.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/models/emoji.dart';
import 'package:xafe/utils/colors.dart';
import 'package:xafe/utils/snackbar.dart';

class AddCategory extends ConsumerStatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  _AddCategoryState createState() => _AddCategoryState();
}

class _AddCategoryState extends ConsumerState<AddCategory> {
  final TextEditingController nameController = TextEditingController();

  bool _isLoading = false;
  void _loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  String? dropdownvalue;

  // var items = [
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];

  // var icons = [
  //   'Icons.house',
  //   'Icons.emoji_transportation',
  //   'Icons.restaurant',
  //   'Icons.medical_services_rounded',
  //   'Icons.monetization_on_rounded' 
  // ];

  // List<EmojiModel> emojis = [
  //   EmojiModel(emoji: 'house', icon: Icon(Icons.house, color: Colors.blue,),),
  //   EmojiModel(emoji: 'transportation', icon: Icon(Icons.emoji_transportation, color: Colors.green)),
  //   EmojiModel(emoji: 'food', icon: Icon(Icons.restaurant, color: Colors.pink)),
  //   EmojiModel(emoji: 'medical', icon: Icon(Icons.medical_services_rounded, color: Colors.orange)),
  //   EmojiModel(emoji: 'money', icon: Icon(Icons.monetization_on_rounded, color: Colors.indigo)),
  // ];

 

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  void _addCategory() async {
    String name = nameController.text.trim();
    _loading();
    await ref
        .read(categoryControllerProvider)
        .addCategory(name, dropdownvalue!, DateTime.now())
        .then((status) => {
              if (status.isSuccess)
                {showSnackBar(context: context, content: 'Added successfully')}
            })
        .catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
    _loading();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<EmojiModel> emojis = ref.watch(categoryControllerProvider).emojis;
    ref.listen(categoryControllerProvider, ((previous, next) {}));
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                    hint: const BodyText(
                      color: AppColors.blackColor,
                      size: 14,
                      weight: FontWeight.w400,
                      text: 'choose category emoji',
                    ),
                    style: const TextStyle(
                        fontFamily: 'Euclid',
                        fontSize: 14,
                        color: AppColors.blackColor),
                    value: dropdownvalue,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: emojis.map((EmojiModel value) {
                      return DropdownMenuItem(
                        value: value.emoji,
                        child: value.icon,
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
        ): const Loader()
      ),
      floatingActionButton: !_isLoading ? Container(
          margin: const EdgeInsets.only(left: 30),
          child: ButtonText(onPressed: _addCategory, text: 'Create Category')): const SizedBox()
    );
  }
}
