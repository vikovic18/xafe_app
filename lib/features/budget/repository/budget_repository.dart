import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/authentication/controllers/auth_exception_firebase_handler.dart';
import 'package:xafe/models/budget.dart';
import 'package:xafe/models/budget_expenses.dart';

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

  static const int timeOutDuration = 30;

  Stream<Iterable<BudgetModel>> allBudget() {
    return budget.snapshots().map((event) => event.docs
        .map((doc) => BudgetModel.fromSnapshot(doc))
        .where((budget) => budget.uid == userUid));
  }

  Future<void> addBudget(double amount, String name, String interval) async {
    try {
      await budget.add({
        "name": name,
        "amount": amount,
        "interval": interval,
        "uid": userUid
      }).timeout(const Duration(seconds: timeOutDuration));
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'API not responded in time ');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editBudget(
      documentId, String name, double amount, String interval) async {
    try {
      await budget.doc(documentId).update({
        "name": name,
        "amount": amount,
        "interval": interval
      }).timeout(const Duration(seconds: timeOutDuration));
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'API not responded in time ');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteBudget({required documentId}) async {
    try {
      await budgetExpenses
          .where('budget', isEqualTo: documentId)
          .get()
          .then((snapshot) => {
                for (var element in snapshot.docs) {element.reference.delete()}
              });
      await budget
          .doc(documentId)
          .delete()
          .timeout(const Duration(seconds: timeOutDuration));
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'API not responded in time');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addBudgetExpenses(double amount, String category, String name,
      String budget, DateTime dateTime, String categoryEmoji) async {
    try {
      await budgetExpenses.add({
        "name": name,
        "amount": amount,
        "category": category,
        "budget": budget,
        "dateTime": dateTime,
        "uid": userUid,
        "categoryEmoji": categoryEmoji
      }).timeout(const Duration(seconds: timeOutDuration));
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'API not responded in time ');
    } catch (e) {
      rethrow;
    }
  }

  Stream<Iterable<BudgetExpensesModel>> allBudgetExpenses(String budgetId) {
    return budgetExpenses.snapshots().map((event) => event.docs
        .map((doc) => BudgetExpensesModel.fromSnapshot(doc))
        .where(
            (expense) => expense.uid == userUid && expense.budget == budgetId));
  }

  Future<List<BudgetExpensesModel>> getBudgetExpenses(String budgetId) async {
    try {
      return await budgetExpenses
          .where('uid', isEqualTo: userUid)
          .where('budget', isEqualTo: budgetId)
          .get()
          .then((value) => value.docs.map((doc) {
            return BudgetExpensesModel.fromSnapshot(doc);
          }).toList());
    } catch (e) {
      rethrow;
    }
  }

  Stream<Iterable<BudgetExpensesModel>> allTotalBudgetExpenses() {
    return budgetExpenses.snapshots().map((event) => event.docs
        .map((doc) => BudgetExpensesModel.fromSnapshot(doc))
        .where((expense) => expense.uid == userUid));
  }
}
