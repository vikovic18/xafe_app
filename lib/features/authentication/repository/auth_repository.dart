import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/authentication/controllers/auth_exception_firebase_handler.dart';
import 'package:xafe/models/user.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  static const int timeOutDuration = 8;

  Stream<User?> getCurrentUserData() {
    Stream<User?> user = auth.authStateChanges();
    // var userData =
    //     await firestore.collection('users').doc(auth.currentUser?.uid).get();
    // UserModel? user;
    // if (userData.data() != null) {
    //   user = UserModel.fromJson(userData.data()!);
    // }
    return user;
  }

 


  Future<void> signUpWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((cred) async {
        UserModel user =
            UserModel(name: name, email: email, uid: cred.user!.uid, income: 0.0);
        await firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
      }).timeout(const Duration(seconds: 60));
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'API not responded in time ');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: timeOutDuration));
    } on TimeoutException {
      throw ApiNotRespondingException(message: 'API not responded in time ');
    } catch (e) {
      rethrow;
    }
  }


  
}
