import 'package:flutter/material.dart';
import 'package:juma/pages/app/browse/browse.dart';

import 'package:juma/pages/app/home/navigator.dart';
import 'package:juma/pages/app/profile/profile.dart';

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
      ): HomeNavigator(),
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
      body: IndexedStack(
        index: currentIndex,
        children: navPages.values.toList(),
      ),
      
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
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
        items: navPages.keys.toList(),
        iconSize: 30,
      ),
    );
  }
}