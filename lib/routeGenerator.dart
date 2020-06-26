import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/onboarding.dart';
import 'package:juma/pages/app/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:juma/pages/entryExperience.dart';

//import 'package:juma/testWidget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch(settings.name) {
      case '/': {
        return PageTransition(type: PageTransitionType.fade, child: Entry());
        //return MaterialPageRoute(builder: (_) => Test());
      }
      case '/onboarding':
        return PageTransition(type: PageTransitionType.fade, child: Onboarding());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
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
          child: Text('ERROR'),
        ),
      );
    });
  }

}