import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/categories/repository/category_repository.dart';
import 'package:xafe/models/category.dart';
import 'package:xafe/utils/snackbar.dart';

final categoryControllerProvider = Provider((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryController(categoryRepository: categoryRepository);
});

class CategoryController {
  final CategoryRepository categoryRepository;

  CategoryController({required this.categoryRepository});

  Future<void> addCategory(BuildContext context, String name, String emoji,
      DateTime dateTime) async {
    categoryRepository.addCategory(name, emoji, dateTime).then(((status) {
      if (status.isSuccess) {
        showSnackBar(context: context, content: 'Added successfully');
      }
    })).catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  Future<void> deleteCategory(BuildContext context, documentId) async {
    categoryRepository.deleteCategory(documentId: documentId).then((status) {
      if (status.isSuccess) {
        showSnackBar(context: context, content: 'Removed successfully');
      }
    }).catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  Stream<Iterable<CategoryModel>> allCategories(BuildContext context) {
    return categoryRepository.allCategeries();
  }

  Future<List<CategoryModel>> getAllCategories() {
    return categoryRepository.getAllCategories();
  }

  //  authController.registration(signUpBody).then((status) {
  //         if (status.isSuccess) {
  //           Get.off(() => const HomePage());
  //         } else {
  //           showCustomSnackbar(status.message);
  //         }

}
