import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/bottom_navigation_bar.dart';
import 'package:xafe/models/user.dart';
import 'package:xafe/utils/snackbar.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData() async {
    var userData = await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null){
      user = UserModel.fromJson(userData.data()!);
    }
    return user;
  }

  void signUpWithEmailAndPassword(
      BuildContext context, String name, String email, String password) async {
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel user = UserModel(name: name, email: email, uid: cred.user!.uid);
      await firestore
          .collection('users')
          .doc(cred.user!.uid)
          .set(user.toJson())
          .then((_) => {
                showSnackBar(
                    context: context, content: 'Registered Successfully')
              });
       Navigator.pushNamedAndRemoveUntil(
          context, CustomizedBottomNavigationBar.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamedAndRemoveUntil(
          context, CustomizedBottomNavigationBar.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }


}
