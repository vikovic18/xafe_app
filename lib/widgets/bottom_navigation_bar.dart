import 'package:flutter/material.dart';
import 'package:xafe/screens/budget/budget.dart';
import 'package:xafe/screens/categories/categories.dart';
import 'package:xafe/screens/home/home.dart';
import 'package:xafe/utils/colors.dart';

class CustomizedBottomNavigationBar extends StatefulWidget {
  const CustomizedBottomNavigationBar({ Key? key }) : super(key: key);

  @override
  _CustomizedBottomNavigationBarState createState() => _CustomizedBottomNavigationBarState();
}

class _CustomizedBottomNavigationBarState extends State<CustomizedBottomNavigationBar> {

   final List<Map<String, dynamic>> _pages = [
    {'page': const Home()},
    {'page': const Categories()},
    {'page': const Budget(),},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: _pages[_selectedPageIndex]['page'],
        bottomNavigationBar: 
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: BottomNavigationBar(
                  backgroundColor: AppColors.whiteColor,
                  elevation: 0,
                  unselectedItemColor: AppColors.greyColor,
                  selectedItemColor: AppColors.blackColor,
                  showUnselectedLabels: true,
                  currentIndex: _selectedPageIndex,
                  onTap: _selectPage,
                  items: const [
                    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: 'Categories'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_cart), label: 'Budget'),
                  ]),
            ),
            // SizedBox(height: 12,),
            // CircularProgressIndicator()
         
        
    );
  }
}