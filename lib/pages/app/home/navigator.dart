import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/pages/app/home/home.dart';
import 'package:juma/routeGenerator.dart';
import 'package:provider/provider.dart';

class HomeNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) Navigator.of(context).pushReplacementNamed('/'); // in case somehow it got here without going through the auth entry check

    return Navigator(
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch(settings.name) {
          case '/': return MaterialPageRoute(builder: (context) => Home());
          default: return RouteGenerator.errorRoute;
        }
      },
    );
  }
}