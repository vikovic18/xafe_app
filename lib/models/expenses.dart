import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesModel {
  String? documentId;
  String? uid;
  String? name;
  double? amount;
  String? category;
  DateTime? dateTime;
  String? categoryEmoji;

  ExpensesModel(
      {required this.documentId,
      required this.name,
      required this.amount,
      required this.uid,
      required this.dateTime,
      required this.category,
      required this.categoryEmoji
      });

  

  ExpensesModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        uid = snapshot.data()['uid'],
        name = snapshot.data()['name'],
        amount = snapshot.data()['amount'],
        category = snapshot.data()['category'],
        categoryEmoji = snapshot.data()['categoryEmoji'],
        dateTime = (snapshot.data()['dateTime'] as Timestamp).toDate();

}