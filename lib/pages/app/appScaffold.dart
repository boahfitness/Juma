import 'package:flutter/material.dart';
import 'package:juma/pages/app/browse/browse.dart';

import 'package:juma/pages/app/home/home.dart';
import 'package:juma/pages/app/profile/profile.dart';

import './appNavigator.dart';

class AppScaffold extends StatefulWidget {
  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int currentIndex = 0;
  List<GlobalKey<NavigatorState>> navKeys;
  Map<BottomNavigationBarItem, Navigator> navPages;

  @override
  void initState() {
    navKeys = [
      GlobalKey(),
      GlobalKey(),
      GlobalKey()
    ];

    navPages = {
      BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home)
      ): AppNavigator(Home(), key: navKeys[0]).nav,
      BottomNavigationBarItem(
            label: 'Browse',
            icon: Icon(Icons.search)
      ): AppNavigator(Browse(), key: navKeys[1]).nav,
      BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person)
      ): AppNavigator(Profile(), key: navKeys[2]).nav,
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navKeys[currentIndex].currentState.maybePop(),
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        body: IndexedStack(
          index: currentIndex,
          children: navPages.values.toList(),
        ),
        
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            if (currentIndex == index) {
              navKeys[index].currentState.popUntil((route) => route.isFirst == true);
            }
            else {
              setState(() {
                currentIndex = index;
              });
            }
          },
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.grey[900],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[700],
          items: navPages.keys.toList(),
          iconSize: 30,
        ),
      ),
    );
  }
}