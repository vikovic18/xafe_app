import 'package:cloud_firestore/cloud_firestore.dart';

class ExpensesModel {
  String? documentId;
  String? uid;
  String? name;
  double? amount;
  String? category;
  DateTime? dateTime;

  ExpensesModel(
      {required this.documentId,
      required this.name,
      required this.amount,
      required this.uid,
      required this.dateTime,
      required this.category
      });

  

  ExpensesModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        uid = snapshot.data()['uid'],
        name = snapshot.data()['name'],
        amount = snapshot.data()['amount'],
        category = snapshot.data()['category'],
        dateTime = (snapshot.data()['dateTime'] as Timestamp).toDate();

}