import 'package:flutter/material.dart';
import 'package:juma/pages/app/home/home.dart';
import 'package:juma/routeGenerator.dart';


var homeNav = Navigator(
  initialRoute: '/',
  onGenerateRoute: (settings) {
    switch(settings.name) {
      case '/': return MaterialPageRoute(builder: (context) => Home());
      default: return RouteGenerator.errorRoute;
    }
  },
);