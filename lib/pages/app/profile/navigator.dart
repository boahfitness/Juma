import 'package:flutter/material.dart';
import 'package:juma/pages/app/profile/profile.dart';
import 'package:juma/routeGenerator.dart';

var profileNav = Navigator(
  initialRoute: '/',
  onGenerateRoute: (settings) {
    switch(settings.name) {
      case '/': return MaterialPageRoute(builder: (context) => Profile());
      default: return RouteGenerator.errorRoute;
    }
  },
);