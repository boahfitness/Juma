import 'package:flutter/material.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/routeGenerator.dart';
import 'package:flutter/services.dart';

void main() => runApp(Juma());

class Juma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,  
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // if user return app else return authenticate
    if (user == null) {
      return Authenticate();
    }
    else {
      //return Home();
      return Center(
        child: Text('Welcome to JUMA', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
      );
    }
  }
}