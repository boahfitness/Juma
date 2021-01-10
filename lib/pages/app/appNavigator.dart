import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/pages/app/home/util/CustomRectTween.dart';
import 'package:juma/pages/app/routes/programDetail.dart';
import 'package:juma/routeGenerator.dart';

import 'package:juma/pages/app/routes/currentProgram.dart';
//import 'package:juma/pages/app/routes/createProgramTemplate.dart';

import 'package:juma/test/testWidget.dart';
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
          //case '/create-program-template': return MaterialPageRoute(builder: (context) => CreateProgramTemplate());
          case '/program-detail': return PageTransition(child: ProgramDetail(program: settings.arguments is Program ? settings.arguments : null), type: PageTransitionType.fade, duration: const Duration(milliseconds: 700));
          //case '/test': return PageTransition(child: TestTwo(program: settings.arguments is Program ? settings.arguments : null), type: PageTransitionType.fade, duration: const Duration(milliseconds: 700));
          default: return RouteGenerator.errorRoute;
        }
      },
      observers: [
        HeroController(
          createRectTween: (begin, end) {
            return CustomRectTween(a: begin, b: end);
          }
        )
      ],
    );
  }
}