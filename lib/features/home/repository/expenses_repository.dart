import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/authentication/controllers/auth_exception_firebase_handler.dart';
import 'package:xafe/models/expenses.dart';
import 'package:xafe/models/user.dart';

final expensesRepositoryProvider = Provider((ref) => ExpensesRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class ExpensesRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ExpensesRepository({required this.auth, required this.firestore});

  final expenses = FirebaseFirestore.instance.collection('expenses');

  final users = FirebaseFirestore.instance.collection('users');

  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> addExpenses(double amount, String category, String name,
      DateTime dateTime, String categoryEmoji) async {
    try {
      await expenses.add({
        "name": name,
        "amount": amount,
        "category": category,
        "dateTime": dateTime,
        "uid": userUid,
        "categoryEmoji": categoryEmoji
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<Iterable<ExpensesModel>> allExpenses() {
    return expenses.snapshots().map((event) => event.docs
        .map((doc) => ExpensesModel.fromSnapshot(doc))
        .where((expense) => expense.uid == userUid));
  }

  Future<void> deleteExpenses({required documentId}) async {
    try {
      await expenses
          .doc(documentId)
          .delete()
          .timeout(const Duration(seconds: 30));
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'API not responded in time');
    } catch (e) {
      rethrow;
    }
  }


  Future<void> addIncome(double income) async {
    try {
      await users.doc(userUid).update({'income': income});
    } catch (e) {
      rethrow;
    }
  }

  Stream<Iterable<UserModel>> getIncome() {
    return users.snapshots().map((event) => event.docs
        .map((doc) => UserModel.fromSnapshot(doc))
        .where((user) => user.uid == userUid));
  }

  // Future<List<UserModel>> getIncome() async{
  //   try {
  //     return await users.where('uid', isEqualTo: userUid).get().then((value) => value.docs.map((e) {
  //       return UserModel.fromSnapshot(e);
  //     }).toList());
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
