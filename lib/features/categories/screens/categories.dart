import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/body_text.dart';
import 'package:xafe/common_widgets/loader.dart';
import 'package:xafe/features/categories/controller/category_controller.dart';
import 'package:xafe/features/categories/screens/add_categories.dart';
import 'package:xafe/features/categories/screens/components/categories_body.dart';
import 'package:xafe/models/category.dart';

import 'package:xafe/utils/colors.dart';

class Categories extends ConsumerWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppColors.blueColor,
        body: SafeArea(
            child: Column(children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.laptop_windows_rounded,
                          size: 24,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        BodyText(
                            color: AppColors.whiteColor,
                            size: 24,
                            text: 'Categories',
                            weight: FontWeight.w600)
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddCategory()),
                        );
                      },
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: AppColors.lightBlueColor,
                        child: Icon(
                          Icons.add,
                          color: AppColors.whiteColor,
                          size: 45,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.02),
          StreamBuilder(
              stream:
                  ref.read(categoryControllerProvider).allCategories(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Loader();
                }
                final allCategories = snapshot.data as Iterable<CategoryModel>;
                return CategoriesBody(categories: allCategories);
              }))
        ])));
  }
}
