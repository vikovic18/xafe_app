import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/models/expenses.dart';
import 'package:xafe/models/response_model.dart';

final expensesRepositoryProvider = Provider((ref) => ExpensesRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class ExpensesRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ExpensesRepository({required this.auth, required this.firestore});

  final expenses = FirebaseFirestore.instance.collection('expenses');

  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<ResponseModel> addExpenses(
      double amount, String category, String name, DateTime dateTime) async {
    late ResponseModel responseModel;
    try {
      await expenses.add({
        "name": name,
        "amount": amount,
        "category": category,
        "dateTime": dateTime,
        "uid": userUid
      });
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Stream<Iterable<ExpensesModel>> allExpenses() {
    return expenses.snapshots().map((event) => event.docs
        .map((doc) => ExpensesModel.fromSnapshot(doc))
        .where((expense) => expense.uid == userUid));
  }

  // Future<List<ExpensesModel>> getAllTotalExpenses() async {
  //   try {
  //     return await expenses
  //         .where('uid', isEqualTo: userUid)
  //         .get()
  //         .then((value) => value.docs.map((doc) {
  //               return ExpensesModel.fromSnapshot(doc);
  //             }).toList());
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
