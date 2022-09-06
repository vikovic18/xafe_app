import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/home/repository/expenses_repository.dart';
import 'package:xafe/models/expenses.dart';
import 'package:xafe/models/response_model.dart';
import 'package:xafe/models/user.dart';

final expensesControllerProvider = Provider((ref) {
  final expensesRepository = ref.watch(expensesRepositoryProvider);
  return ExpensesController(expensesRepository: expensesRepository);
});

final allExpensesControllerProvider = StreamProvider((ref) {
  final expensesController = ref.watch(expensesControllerProvider);
  return expensesController.allExpenses();
});

final incomeControllerProvider = StreamProvider((ref) {
  final expensesController = ref.watch(expensesControllerProvider);
  return expensesController.getIncome();
});

class ExpensesController {
  final ExpensesRepository expensesRepository;

  ExpensesController({required this.expensesRepository});

  Future<ResponseModel> addExpenses(String name, double amount, String category,
      DateTime dateTime, String categoryEmoji) async {
    late ResponseModel responseModel;
    try {
      await expensesRepository.addExpenses(
          amount, category, name, dateTime, categoryEmoji);
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Stream<Iterable<ExpensesModel>> allExpenses() {
    return expensesRepository.allExpenses();
  }

  Future<ResponseModel> addIncome(double income) async {
    late ResponseModel responseModel;
    try {
      await expensesRepository.addIncome(income);
      responseModel = ResponseModel(true, 'Added Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Future<ResponseModel> deleteExpenses(documentId) async {
    late ResponseModel responseModel;
    try {
      await expensesRepository.deleteExpenses(documentId: documentId);
      responseModel = ResponseModel(true, 'Deleted Successfully');
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
      rethrow;
    }
    return responseModel;
  }

  Stream<Iterable<UserModel>> getIncome() {
    return expensesRepository.getIncome();
  }
}
