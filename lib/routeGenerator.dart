import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:juma/pages/appEntry.dart';

import 'package:juma/test/testWidget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return PageTransition(type: PageTransitionType.fade, child: AppEntry());
        //return MaterialPageRoute(builder: (_) => Test());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('INVALID ROUTE'),
        ),
      );
    });
  }

  static Route<dynamic> get errorRoute => _errorRoute();

}