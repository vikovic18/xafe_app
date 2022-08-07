import 'package:flutter/material.dart';
import 'package:xafe/screens/login/login.dart';
import 'package:xafe/screens/sign_up/components/sign_up_fields.dart';
import 'package:xafe/screens/sign_up/sign_up.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}


