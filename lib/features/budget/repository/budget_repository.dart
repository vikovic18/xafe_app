import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/models/budget.dart';
import 'package:xafe/models/budget_expenses.dart';
import 'package:xafe/models/response_model.dart';

final budgetRepositoryProvider = Provider((ref) => BudgetRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class BudgetRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  BudgetRepository({required this.auth, required this.firestore});

  final budget = FirebaseFirestore.instance.collection('budget');
  final budgetExpenses =
      FirebaseFirestore.instance.collection('budget_expenses');

  final String userUid = FirebaseAuth.instance.currentUser!.uid;

  Future<ResponseModel> addBudget(
      double amount, String name, String interval) async {
    late ResponseModel responseModel;
    try {
      await budget.add({
        "name": name,
        "amount": amount,
        "interval": interval,
        "uid": userUid
      });
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Stream<Iterable<BudgetModel>> allBudget() {
    return budget.snapshots().map((event) => event.docs
        .map((doc) => BudgetModel.fromSnapshot(doc))
        .where((budget) => budget.uid == userUid));
  }

  Future<ResponseModel> editBudget(
      documentId, String name, double amount, String interval) async {
    late ResponseModel responseModel;
    try {
      await budget
          .doc(documentId)
          .update({"name": name, "amount": amount, "interval": interval});
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Future<ResponseModel> deleteBudget({required documentId}) async {
    late ResponseModel responseModel;
    try {
      await budgetExpenses
          .where('budget', isEqualTo: documentId)
          .get()
          .then((snapshot) => {
                for (var element in snapshot.docs) {element.reference.delete()}
              });
      await budget.doc(documentId).delete();
      responseModel = ResponseModel(true, 'Deleted Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Future<ResponseModel> addBudgetExpenses(double amount, String category,
      String name, String budget, DateTime dateTime) async {
    late ResponseModel responseModel;
    try {
      await budgetExpenses.add({
        "name": name,
        "amount": amount,
        "category": category,
        "budget": budget,
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

  Stream<Iterable<BudgetExpensesModel>> allBudgetExpenses(String budgetId) {
    return budgetExpenses.snapshots().map((event) => event.docs
        .map((doc) => BudgetExpensesModel.fromSnapshot(doc))
        .where(
            (expense) => expense.uid == userUid && expense.budget == budgetId));
  }

  Stream<Iterable<BudgetExpensesModel>> allTotalBudgetExpenses() {
    return budgetExpenses.snapshots().map((event) => event.docs
        .map((doc) => BudgetExpensesModel.fromSnapshot(doc))
        .where((expense) => expense.uid == userUid));
  }
}
