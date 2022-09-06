
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/authentication/controllers/auth_exception_firebase_handler.dart';
import 'package:xafe/features/authentication/controllers/error_controller.dart';
import 'package:xafe/features/authentication/repository/auth_repository.dart';


final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

final userDataAuthProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController with ErrorController  {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});



  Stream<User?> getUserData() {
    Stream<User?> user = authRepository.getCurrentUserData();
    return user;
  }

  Future<AuthResultStatus> signUpWithEmailAndPassword(
      String name, String email, String password) async {
   late AuthResultStatus _status;
    try {
      await authRepository.signUpWithEmailAndPassword(name, email, password);
      _status = AuthResultStatus.successful;
    } catch (e) {
     _status = AuthExceptionHandler.handleException(e);
      rethrow;
    }
    return _status;
  }

  Future<AuthResultStatus> signInWithEmailAndPassword(
      String email, String password) async {
     late AuthResultStatus _status;
    try {
      await authRepository.signInWithEmailAndPassword(email, password);
      _status = AuthResultStatus.successful;
    } catch (e) {
      // print("Controller " + e.toString());
      _status = AuthExceptionHandler.handleException(e);
    }
    return _status;
    
  }
}
