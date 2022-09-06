import 'package:flutter/material.dart';
import 'package:xafe/features/home/screens/components/expenses.dart';
import 'package:xafe/features/home/screens/components/summary.dart';
import 'package:xafe/utils/colors.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.blueColor,
      body: SafeArea(
        child: Column(
          children:  [
            const Summary(),
            Expenses()
          ],
        )
      ),
    );
  }
}