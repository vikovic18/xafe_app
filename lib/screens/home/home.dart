import 'package:flutter/material.dart';
import 'package:xafe/screens/home/components/expenses.dart';
import 'package:xafe/screens/home/components/summary.dart';
import 'package:xafe/utils/colors.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.blueColor,
      body: SafeArea(
        child: Column(
          children: [
            Summary(),
            Expenses()
          ],
        )
      ),
    );
  }
}