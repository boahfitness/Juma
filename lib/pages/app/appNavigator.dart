import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/routeGenerator.dart';

import 'package:juma/pages/app/routes/currentProgram.dart';

class AppNavigator {
  Widget baseRoute;
  GlobalKey<NavigatorState> key;

  AppNavigator(this.baseRoute, {this.key});

  Navigator get nav {
    return Navigator(
      key: key,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/': return MaterialPageRoute(builder: (context) => baseRoute);
          case '/current-program': return MaterialPageRoute(builder: (context) => CurrentProgram(settings.arguments is ProgramHistory ? settings.arguments : null));
          default: return RouteGenerator.errorRoute;
        }
      },
    );
  }
}