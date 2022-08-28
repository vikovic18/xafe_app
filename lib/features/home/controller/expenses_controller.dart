import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/home/repository/expenses_repository.dart';
import 'package:xafe/models/expenses.dart';
import 'package:xafe/utils/snackbar.dart';

final expensesControllerProvider = Provider((ref) {
  final expensesRepository = ref.watch(expensesRepositoryProvider);
  return ExpensesController(expensesRepository: expensesRepository);
});

final allExpensesControllerProvider = StreamProvider((ref){
  final expensesController = ref.watch(expensesControllerProvider);
  return expensesController.allExpenses();
});

class ExpensesController {
  final ExpensesRepository expensesRepository;

  ExpensesController({required this.expensesRepository});

  Future<void> addExpenses(BuildContext context, String name, double amount,
      String category, DateTime dateTime) async {
    expensesRepository
        .addExpenses(amount, category, name, dateTime)
        .then(((status) {
      if (status.isSuccess) {
        showSnackBar(context: context, content: 'Added successfully');
      }
    })).catchError((error) {
      showSnackBar(context: context, content: error.toString());
    });
  }

   Stream<Iterable<ExpensesModel>> allExpenses(){
    return expensesRepository.allExpenses();
  }

 

}
