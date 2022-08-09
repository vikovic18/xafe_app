import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/models/category.dart';
import 'package:xafe/utils/snackbar.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class CategoryRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  CategoryRepository({required this.auth, required this.firestore});

  final categories = FirebaseFirestore.instance.collection('categories');

  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addCategory(
      BuildContext context, String name, String emoji) async {
    try {
     
      CategoryModel category =
          CategoryModel(emoji: emoji, name: name, uid: userUid);
      await categories.add(category.toJson());
      showSnackBar(context: context, content: 'Added successfully');
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  // Stream<List<CategoryModel>> getCategories(){
  //   categories.where
  // }
    
}
