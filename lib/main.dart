import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juma/services/userService.dart';
import 'package:provider/provider.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/routeGenerator.dart';
import 'package:flutter/services.dart';

void main() => runApp(
  AuthenticationProvider(
    child: Juma(),
  )
);

class Juma extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(fontFamily: 'Montserrat', brightness: Brightness.dark),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}


/// Authentcation wrapper for the whole app. Checks to make sure a firebase user is logged in
class AuthenticationProvider extends StatelessWidget {
  final Widget child;
  AuthenticationProvider({this.child});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: UserProvider(child: child,),
    );
  }
}

/// The user data provider for the whole app. If Authprovider has a user logged, this will provide that users data
class UserProvider extends StatelessWidget {
  final Widget child;
  UserProvider({this.child});
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: UserService().user(Provider.of<FirebaseUser>(context) != null ? Provider.of<FirebaseUser>(context).uid : 'thisIsABadUserID'),
      catchError: (context, object) {
        return null;
      },
      child: child,
    );
  }
}