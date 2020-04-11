import 'package:flutter/material.dart';
import 'package:juma/pages/authenticate/authenticate.dart';
//import 'package:juma/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/models/user.dart';

void main() => runApp(StreamProvider<User>.value(
  value: AuthService().user,
  child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Authenticate(),
        },
      ),
));