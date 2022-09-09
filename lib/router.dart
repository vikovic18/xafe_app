import 'package:flutter/material.dart';
import 'package:xafe/common_widgets/error.dart';
import 'package:xafe/features/authentication/screens/login/login.dart';
import 'package:xafe/features/authentication/screens/sign_up/components/sign_up_fields.dart';
import 'package:xafe/features/bottom_navigation_bar.dart';
import 'package:xafe/features/budget/screens/budget_details.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: ((context) => const LoginScreen()));
    case SignUpName.routeName:
      return MaterialPageRoute(builder: ((context) => const SignUpName()));
    case SignUpEmail.routeName:
      final name = settings.arguments as String;
      return MaterialPageRoute(builder: (context) => SignUpEmail(name: name));
    // case SignUpCode.routeName:
    //   final args = settings.arguments as SignUpCode;
    //   return MaterialPageRoute(
    //       builder: (context) => SignUpCode(name: args.name, email: args.email));
    case SignupPassword.routeName:
      final args = settings.arguments as SignupPassword;
      return MaterialPageRoute(
          builder: (context) => SignupPassword(name: args.name, email: args.email));
    case CustomizedBottomNavigationBar.routeName:
      return MaterialPageRoute(
          builder: (context) => const CustomizedBottomNavigationBar());
    case BudgetDetails.routeName:
      final args = settings.arguments as Map<String, dynamic>;
      final name = args['name'];
      final id = args['id'];
      final amount = args['amount'];
      final interval = args['interval'];
      // final totalPct = args['totalPct'];
      // final sum = args['sum'];
      return MaterialPageRoute(
          builder: (context) => BudgetDetails(name: name, id: id, amount: amount, interval: interval));
    default:
      return MaterialPageRoute(
          builder: ((context) => const Scaffold(
                body: ErrorScreen(error: 'This page does not exist'),
              )));
  }
}
