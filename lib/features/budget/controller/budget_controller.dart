import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/budget/repository/budget_repository.dart';
import 'package:xafe/models/budget.dart';
import 'package:xafe/models/budget_expenses.dart';
import 'package:xafe/models/response_model.dart';

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

  Stream<Iterable<BudgetModel>> allBudget() {
    return budgetRepository.allBudget();
  }

  Future<ResponseModel> addBudget(
      String name, double amount, String interval) async {
    late ResponseModel responseModel;
    try {
      await budgetRepository.addBudget(amount, name, interval);
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Future<ResponseModel> editBudget(documentId, name, amount, interval) async {
    late ResponseModel responseModel;
    try {
      await budgetRepository.editBudget(documentId, name, amount, interval);
      responseModel = ResponseModel(true, 'Edited Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Future<ResponseModel> deleteBudget(documentId) async {
    late ResponseModel responseModel;
    try {
      await budgetRepository.deleteBudget(documentId: documentId);
      responseModel = ResponseModel(true, 'Deleted Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Future<ResponseModel> addBudgetExpenses(String name, double amount,
      String category, String budget, DateTime dateTime, String categoryEmoji) async {
    late ResponseModel responseModel;
    try {
      await budgetRepository.addBudgetExpenses(
          amount, category, name, budget, dateTime, categoryEmoji);
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Stream<Iterable<BudgetExpensesModel>> allBudgetExpenses(String budgetId) {
    return budgetRepository.allBudgetExpenses(budgetId);
  }

  Stream<Iterable<BudgetExpensesModel>> allTotalBudgetExpenses() {
    return budgetRepository.allTotalBudgetExpenses();
  }

  Future<double> getBudgetExpensesAmount(String budgetId) async {
    double sum = 0;
    List<BudgetExpensesModel> allBudgetExpenses =
        await budgetRepository.getBudgetExpenses(budgetId);
    for (var element in allBudgetExpenses) {
      sum += element.amount!;
    }
    return sum;
  }
}
