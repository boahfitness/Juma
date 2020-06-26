import 'package:flutter/material.dart';
import 'package:juma/pages/app/browse.dart';
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

    Map<BottomNavigationBarItem, Widget> navPages = {
      BottomNavigationBarItem(
            title: Text('Home'),
            icon: Icon(Icons.home)
      ): Home(),
      BottomNavigationBarItem(
            title: Text('Browse'),
            icon: Icon(Icons.search)
      ): Browse(),
      BottomNavigationBarItem(
            title: Text('Profile'),
            icon: Icon(Icons.person)
      ): Profile(),
    };

    return Scaffold(
      backgroundColor: Colors.black,
      body: navPages.values.toList()[currentIndex],
      
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
        items: navPages.keys.toList(),
      ),
    );
  }
}