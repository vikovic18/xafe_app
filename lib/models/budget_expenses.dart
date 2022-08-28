import 'package:cloud_firestore/cloud_firestore.dart';

class BudgetExpensesModel {
  String? documentId;
  String? uid;
  String? name;
  double? amount;
  String? category;
  String? budget;
  DateTime? dateTime;

  BudgetExpensesModel(
      {required this.documentId,
      required this.name,
      required this.amount,
      required this.uid,
      required this.dateTime,
      required this.category,
      required this.budget
      });

  

  BudgetExpensesModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        uid = snapshot.data()['uid'],
        name = snapshot.data()['name'],
        amount = snapshot.data()['amount'],
        category = snapshot.data()['category'],
        budget = snapshot.data()['budget'],
        dateTime = (snapshot.data()['dateTime'] as Timestamp).toDate();

}