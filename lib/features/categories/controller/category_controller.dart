import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/categories/repository/category_repository.dart';

final categoryControllerProvider = Provider((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryController(categoryRepository: categoryRepository);
});


class CategoryController {
  final CategoryRepository categoryRepository;

  CategoryController({required this.categoryRepository});

  Future<void> addCategory(BuildContext context, String name, String emoji) async{
    categoryRepository.addCategory(context, name, emoji);
  }

}
