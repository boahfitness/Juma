import 'package:flutter/material.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/models/user.dart';

void main() => runApp(Juma());

class Juma extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Oswald'),
        home: Wrapper(),
      ),
    );
  }
}

// sends user to auth branch or app branch based on login
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    //print(user.uid);

    if (user == null) {
      return Authenticate();
    }
    else {
      return Home();
    }
  }
}