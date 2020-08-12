import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/pages/app/routes/mediaCapture.dart';
import 'package:juma/routeGenerator.dart';

import 'package:juma/pages/app/routes/currentProgram.dart';
import 'package:juma/pages/app/routes/createProgramTemplate.dart';
import 'package:page_transition/page_transition.dart';

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
          case '/create-program-template': return MaterialPageRoute(builder: (context) => CreateProgramTemplate());
          case '/media-capture': return PageTransition(child: MediaCapture(), type: PageTransitionType.fade, curve: Curves.easeInOut);
          default: return RouteGenerator.errorRoute;
        }
      },
    );
  }
}