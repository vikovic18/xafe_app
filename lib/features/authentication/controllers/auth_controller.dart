import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/features/authentication/repository/auth_repository.dart';
import 'package:xafe/models/user.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }


  void signUpWithEmailAndPassword(BuildContext context,String name, String email, String password){
    authRepository.signUpWithEmailAndPassword(context, name, email, password);
  }

  void signInWithEmailAndPassword(BuildContext context, String email, String password){
    authRepository.signInWithEmailAndPassword(context, email, password);
  }
 
}
