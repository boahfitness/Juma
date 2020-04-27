import 'package:flutter/material.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/models/user.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/routeGenerator.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        theme: ThemeData(fontFamily: 'Oswald'),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
        
      ),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      child: Image.asset("assets/juma-logo-stroke-grad.png",),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: JumaColors.boahOrange,
            blurRadius: 15,
            spreadRadius: 15
          )
        ]
      ),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Future checkSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //bool seen = prefs.getBool('seen') ?? false;
    bool seen = false;

    if (seen) {
      print('Onboarding has already been seen! going to auth');
      Navigator.of(context).pushReplacementNamed('/auth');
    } else {
      print('first time here! going to onboarding');
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
  }

  @override
  void initState() {
    checkSeen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
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
      return Home();
    }
  }
}