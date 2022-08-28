import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: empty_constructor_bodies
class BudgetModel {
  String? documentId;
  String? name;
  double? amount;
  String? uid;
  String? interval; 

  BudgetModel(
      {required this.documentId,
      required this.name,
      required this.amount,
      required this.uid,
      required this.interval
      });

  Map<String, dynamic> toJson() => {
        "name": name,
        "emoji": amount,
        "uid": uid,
        "interval": interval
      };


  BudgetModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        uid = snapshot.data()['uid'],
        name = snapshot.data()['name'],
        amount = snapshot.data()['amount'],
        interval = snapshot.data()['interval'];
}
