import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xafe/common_widgets/bottom_navigation_bar.dart';
import 'package:xafe/common_widgets/loader.dart';

import 'package:xafe/features/authentication/controllers/auth_controller.dart';
import 'package:xafe/features/authentication/controllers/auth_exception_firebase_handler.dart';
import 'package:xafe/features/authentication/screens/sign_up/components/sign_up_body.dart';
import 'package:xafe/features/splash/screens/splash_screen.dart';
import 'package:xafe/utils/custom_error_alert.dart';

import 'package:xafe/utils/snackbar.dart';

//SignUpName

class SignUpName extends StatefulWidget {
  static const routeName = '/signupname-screen';
  const SignUpName({Key? key}) : super(key: key);

  @override
  State<SignUpName> createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpBody(
        onPressed: () {
          Navigator.pushNamed(context, SignUpEmail.routeName,
              arguments: nameController.text.trim());
        },
        controller: nameController,
        keyboardType: TextInputType.name,
        title: "What's your name?",
        subtitle: "Enter your first and last name");
  }
}

//SignUpEmail

class SignUpEmail extends StatefulWidget {
  static const routeName = '/signupemail-screen';
  final String name;
  const SignUpEmail({Key? key, required this.name}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpBody(
        onPressed: () {
          Navigator.pushNamed(context, SignUpCode.routeName,
              arguments: SignUpCode(
                  name: widget.name, email: emailController.text.trim()));
        },
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        title: "What's your email?",
        subtitle: "Enter your email address");
  }
}

//SignUpCode

class SignUpCode extends StatefulWidget {
  static const routeName = '/signupcode-screen';
  final String name;
  final String email;
  const SignUpCode({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  _SignUpCodeState createState() => _SignUpCodeState();
}

class _SignUpCodeState extends State<SignUpCode> {
  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpBody(
        onPressed: () {
          Navigator.pushNamed(context, SignupPassword.routeName,
              arguments:
                  SignupPassword(name: widget.name, email: widget.email));
        },
        controller: codeController,
        keyboardType: TextInputType.number,
        title: "Enter the code",
        subtitle: "Enter the code sent to your email address");
  }
}

//SignUpPassword

class SignupPassword extends ConsumerStatefulWidget {
  static const routeName = '/signuppassword-screen';
  final String name;
  final String email;
  const SignupPassword({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  _SignupPasswordState createState() => _SignupPasswordState();
}

class _SignupPasswordState extends ConsumerState<SignupPassword> {
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  void _loading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void dispose() {
    super.dispose();
    passwordController.dispose();
  }

  void _registerUser() async {
    if (widget.name.isNotEmpty && widget.email.isNotEmpty) {
      _loading();
      await ref
          .read(authControllerProvider)
          .signUpWithEmailAndPassword(
              widget.name, widget.email, passwordController.text.trim())
          .then((status) {
        if (status == AuthResultStatus.successful) {
          Navigator.pushNamedAndRemoveUntil(context,
              CustomizedBottomNavigationBar.routeName, (route) => false);
        } else {
          final errorMsg =
              AuthExceptionHandler.generateExceptionMessage(status);
          showCustomErrorDialog(context, errorMsg).then((_) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const SplashScreen()),
              );
          });

        }
      })
      .catchError((error) {
        showCustomErrorDialog(
            context, "Check your internet connection, and try again.");
      });
      _loading();
    } 
    else {
      showSnackBar(context: context, content: 'Input the required fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? SignUpBody(
            onPressed: _registerUser,
            controller: passwordController,
            isObscure: true,
            keyboardType: TextInputType.name,
            title: "Add a Password",
            subtitle: "Enter password")
        : const Loader();
  }
}
