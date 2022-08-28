import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/budget/repository/budget_repository.dart';
import 'package:xafe/models/budget.dart';
import 'package:xafe/models/budget_expenses.dart';
import 'package:xafe/utils/snackbar.dart';

final budgetControllerProvider = Provider((ref) {
  final budgetRepository = ref.watch(budgetRepositoryProvider);
  return BudgetController(budgetRepository: budgetRepository);
});

final budgetExpensesProvider =
    StreamProvider.family<Iterable<BudgetExpensesModel>, String>(
        (ref, budgetId) {
  final budgetController = ref.watch(budgetControllerProvider);
  return budgetController.allBudgetExpenses(budgetId);
});

final allTotalBudgetExpensesProvider = StreamProvider((ref) {
  final budgetController = ref.watch(budgetControllerProvider);
  return budgetController.allTotalBudgetExpenses();
});

class BudgetController {
  final BudgetRepository budgetRepository;

  BudgetController({required this.budgetRepository});

  Future<void> addBudget(
      BuildContext context, String name, double amount, String interval) async {
    budgetRepository.addBudget(amount, name, interval).then(((status) {
      if (status.isSuccess) {
        showSnackBar(context: context, content: 'Added successfully');
      }
    })).catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  Stream<Iterable<BudgetModel>> allBudget(BuildContext context) {
    return budgetRepository.allBudget();
  }

  Future<void> editBudget(
      BuildContext context, documentId, name, amount, interval) async {
    budgetRepository
        .editBudget(documentId, name, amount, interval)
        .then((status) {
      if (status.isSuccess) {
        showSnackBar(context: context, content: 'Edited successfully');
      }
    }).catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  Future<void> deleteBudget(BuildContext context, documentId) async {
    budgetRepository.deleteBudget(documentId: documentId).then((status) {
      if (status.isSuccess) {
        showSnackBar(context: context, content: 'Removed successfully');
      }
    }).catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  Future<void> addBudgetExpenses(BuildContext context, String name,
      double amount, String category, String budget, DateTime dateTime) async {
    budgetRepository
        .addBudgetExpenses(amount, category, name, budget, dateTime)
        .then(((status) {
      if (status.isSuccess) {
        showSnackBar(context: context, content: 'Added successfully');
      }
    })).catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

  Stream<Iterable<BudgetExpensesModel>> allBudgetExpenses(
      String budgetId) {
    return budgetRepository.allBudgetExpenses(budgetId);
  }

  // Stream<Iterable<BudgetExpensesModel>> getAllBudgetExpensesList(
  //     String budgetId) {
  //   return budgetRepository.getAllBudgetExpensesList(budgetId);
  // }

  Stream<Iterable<BudgetExpensesModel>> allTotalBudgetExpenses() {
    return budgetRepository.allTotalBudgetExpenses();
  }
}
