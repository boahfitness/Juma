import 'package:flutter/material.dart';
import 'package:juma/main.dart';
import 'package:juma/pages/onboarding/onboarding.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/authenticate/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:juma/pages/onboarding/entryExperience.dart';

import 'package:juma/pages/onboarding/signup/inputPages/createPR/createPR.dart';

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
      case '/auth':
        return MaterialPageRoute(builder: (_) => AuthChecker());
      case '/auth/login':
        return MaterialPageRoute(builder: (_) => Login());
      case '/create-pr':
        return MaterialPageRoute(builder: (_) => CreatePR());
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