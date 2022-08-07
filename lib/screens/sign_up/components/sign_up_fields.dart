import 'package:flutter/material.dart';
import 'package:xafe/screens/sign_up/components/sign_up_body.dart';
import 'package:xafe/screens/sign_up/sign_up.dart';

class SignUpName extends StatefulWidget {
  const SignUpName({Key? key}) : super(key: key);

  @override
  State<SignUpName> createState() => _SignUpNameState();
}

class _SignUpNameState extends State<SignUpName> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpBody(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpEmail()),
          );
        },
        controller: nameController,
        title: "What's your name?",
        subtitle: "Enter your first and last name");
  }
}

class SignUpEmail extends StatefulWidget {
  const SignUpEmail({Key? key}) : super(key: key);

  @override
  _SignUpEmailState createState() => _SignUpEmailState();
}

class _SignUpEmailState extends State<SignUpEmail> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpBody(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpCode()),
          );
        },
        controller: emailController,
        title: "What's your email?",
        subtitle: "Enter your email address");
  }
}

class SignUpCode extends StatefulWidget {
  const SignUpCode({Key? key}) : super(key: key);

  @override
  _SignUpCodeState createState() => _SignUpCodeState();
}

class _SignUpCodeState extends State<SignUpCode> {
  final TextEditingController codeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpBody(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupPassword()),
          );
        },
        controller: codeController,
        title: "Enter the code",
        subtitle: "Enter the code sent to your email address");
  }
}

class SignupPassword extends StatefulWidget {
  const SignupPassword({Key? key}) : super(key: key);

  @override
  _SignupPasswordState createState() => _SignupPasswordState();
}

class _SignupPasswordState extends State<SignupPassword> {
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SignUpBody(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  SignUp()),
          );
        },
        controller: passwordController,
        title: "Add a Password",
        subtitle: "Enter password");
  }
}
