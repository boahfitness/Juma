import 'package:flutter/material.dart';
import 'package:juma/pages/login.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
      },
    ));