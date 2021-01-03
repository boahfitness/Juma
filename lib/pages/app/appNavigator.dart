import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/routeGenerator.dart';

import 'package:juma/pages/app/routes/currentProgram.dart';
import 'package:juma/pages/app/routes/createProgramTemplate.dart';

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
          case '/create-program-template': return MaterialPageRoute(builder: (context) => CreateProgramTemplate());
          //case '/test': return MaterialPageRoute(builder: (context) => TestTwo(program: settings.arguments is Program ? settings.arguments : null,));
          case '/test': return PageTransition(child: TestTwo(program: settings.arguments is Program ? settings.arguments : null), type: PageTransitionType.fade, duration: const Duration(milliseconds: 500));
          default: return RouteGenerator.errorRoute;
        }
      },
      observers: [
        HeroController(
          createRectTween: (begin, end) {
            return _CustomRectTween(a: begin, b: end);
          }
        )
      ],
    );
  }
}

class _CustomRectTween extends RectTween {
  final Rect a, b;
  _CustomRectTween({this.a, this.b}) : super(begin: a, end: b);

  @override
  Rect lerp(double t) {
    final value = t; // linear

    return Rect.fromLTRB(
      lerpDouble(a.left, b.left, value),
      lerpDouble(a.top, b.top, value),
      lerpDouble(a.right, b.right, value),
      lerpDouble(a.bottom, b.bottom, value),
    );
  }

  double lerpDouble(num a, num b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}