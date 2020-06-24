import 'package:flutter/material.dart';
import 'package:juma/theme/Colors.dart';

import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/app/profile.dart';

class AppScaffold extends StatefulWidget {
  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> navPages = [
      Home(),
      Profile(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: navPages[currentIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.grey[900],
        selectedItemColor: JumaColors.boahOrange,
        unselectedItemColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.person)
          ),
        ],
      ),
    );
  }
}