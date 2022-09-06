import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/models/category.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class CategoryRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  CategoryRepository({required this.auth, required this.firestore});

  final categories = FirebaseFirestore.instance.collection('categories');

  final budgetExpenses = FirebaseFirestore.instance.collection('budget_expenses');

  final expenses = FirebaseFirestore.instance.collection('expenses');

  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addCategory(
      String name, String emoji, DateTime dateTime) async {
    try {
      await categories.add(
          {"name": name, "emoji": emoji, "uid": userUid, "dateTime": dateTime});
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryModel>> getAllCategories() async {
    try {
      return await categories
          .where('uid', isEqualTo: userUid)
          .get()
          .then((value) => value.docs.map((doc) {
            return CategoryModel.fromSnapshot(doc);
          }).toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<Iterable<CategoryModel>> allCategeries() {
    return categories.snapshots().map((event) => event.docs
        .map((doc) => CategoryModel.fromSnapshot(doc))
        .where((category) => category.uid == userUid));
  }

  Future<void> deleteCategory({required documentId}) async {
    try {
      await expenses
          .where('category', isEqualTo: documentId)
          .get()
          .then((snapshot) => {
                for (var element in snapshot.docs) {element.reference.delete()}
              });
      await budgetExpenses
          .where('category', isEqualTo: documentId)
          .get()
          .then((snapshot) => {
                for (var element in snapshot.docs) {element.reference.delete()}
              });
      await categories.doc(documentId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
