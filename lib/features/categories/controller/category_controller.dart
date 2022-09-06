import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/categories/repository/category_repository.dart';
import 'package:xafe/models/category.dart';
import 'package:xafe/models/emoji.dart';
import 'package:xafe/models/response_model.dart';

final categoryControllerProvider = Provider((ref) {
  final categoryRepository = ref.watch(categoryRepositoryProvider);
  return CategoryController(categoryRepository: categoryRepository);
});

final allCategoriesProvider = StreamProvider((ref) {
  final categoryController = ref.watch(categoryControllerProvider);
  return categoryController.allCategories();
});

class CategoryController {
  final CategoryRepository categoryRepository;

  CategoryController({required this.categoryRepository});

  List<EmojiModel> emojis = [
    EmojiModel(
      emoji: 'house',
      icon: const Icon(
        Icons.house,
        color: Colors.blue,
      ),
    ),
    EmojiModel(
        emoji: 'transportation',
        icon: const Icon(Icons.emoji_transportation, color: Colors.green)),
    EmojiModel(
        emoji: 'food', icon: const Icon(Icons.restaurant, color: Colors.orange)),
    EmojiModel(
        emoji: 'medical',
        icon: const Icon(Icons.medical_services_rounded, color: Colors.pink)),
    EmojiModel(
        emoji: 'money',
        icon: const Icon(Icons.monetization_on_rounded, color: Colors.indigo)),
  ];

  Future<ResponseModel> addCategory(
      String name, String emoji, DateTime dateTime) async {
    late ResponseModel responseModel;
    try {
      await categoryRepository.addCategory(name, emoji, dateTime);
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Future<ResponseModel> deleteCategory(documentId) async {
    late ResponseModel responseModel;
    try {
      await categoryRepository.deleteCategory(documentId: documentId);
      responseModel = ResponseModel(true, 'Deleted Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Stream<Iterable<CategoryModel>> allCategories() {
    return categoryRepository.allCategeries();
  }

  Future<List<CategoryModel>> getAllCategories() {
    return categoryRepository.getAllCategories();
  }
}
