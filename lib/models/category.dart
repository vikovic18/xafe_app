import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: empty_constructor_bodies
class CategoryModel {
  String? documentId;
  String? name;
  String? emoji;
  String? uid;
  DateTime? dateTime;

  CategoryModel(
      {required this.documentId,
      required this.name,
      required this.emoji,
      required this.uid,
      required this.dateTime
      });

  Map<String, dynamic> toJson() => {
        "name": name,
        "emoji": emoji,
        "uid": uid,
        "dateTime": dateTime
      };

  // CategoryModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   emoji = json['emoji'];
  //   uid = json['uid'];
  // }

  CategoryModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        uid = snapshot.data()['uid'],
        name = snapshot.data()['name'],
        emoji = snapshot.data()['emoji'],
        dateTime = (snapshot.data()['dateTime'] as Timestamp).toDate();
}
