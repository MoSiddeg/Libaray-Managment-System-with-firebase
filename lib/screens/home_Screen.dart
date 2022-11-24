import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:loginsignup/screens/upload_Page.dart';
import 'package:loginsignup/styles/app_colors.dart';
import 'SearchPage.dart';
import 'home_Page.dart';
import 'loanSearch.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int selectedIndex = 0;
  final screen = [homePage(),uploadPage(),SearchAppBar(),LoanAppBar()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColors.blue,
        buttonBackgroundColor: Color.fromRGBO(72, 76, 82, 0.16),
        height: 60,
        animationDuration: Duration(
          milliseconds: 200,
        ),
        index: 0, //.. default start position for icon
        animationCurve: Curves.bounceInOut,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.white,),
          Icon(Icons.add,size: 30, color: Colors.white,),
          Icon(Icons.search, size: 30,color: Colors.white,),
          Icon(Icons.history, size: 30, color: Colors.white,),
        ],

        onTap: (index){
          setState(() {
            selectedIndex = index;
          });

        },
      ),
      body: screen[selectedIndex],

    );
  }
}
