import 'package:flutter/material.dart';
import 'package:juma/main.dart';
import 'package:juma/pages/onboarding/onboarding.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/authenticate/authenticate.dart';
import 'package:juma/pages/authenticate/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    SharedPreferences prefs;
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });

    switch(settings.name) {
      // on home route check if seen -> onboarding or authenticate
      case '/':
        return MaterialPageRoute(builder: (_) => Splash());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => Onboarding());
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/auth':
        return MaterialPageRoute(builder: (_) => Authenticate());
      case '/auth/login':
        return MaterialPageRoute(builder: (_) => Login());
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


// if seen return to autch checker else return onboarding
Route<dynamic> _checkSeen(SharedPreferences prefs) {
  bool seen = prefs.getBool('seen') ?? false;

  if (seen) {
    return MaterialPageRoute(
      builder: (_) => AuthChecker()
    );
  }
  else {
    return PageTransition(
      type: PageTransitionType.fade,
      child: Onboarding()
    );
  }
}