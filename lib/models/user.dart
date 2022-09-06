

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? uid;
  double? income;

  UserModel({required this.name, required this.email, required this.uid, required this.income});

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "uid": uid,
    "income": income,
  };


  UserModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      :
        name = snapshot.data()['name'],
        email = snapshot.data()['email'],
        uid = snapshot.data()['uid'],
        income = snapshot.data()['income'];

  // UserModel.fromJson(Map<String, dynamic> json) {
  //   name = json['name'];
  //   email = json['email'];
  //   uid = json['uid'];
  //   income = 
  // }

}


  