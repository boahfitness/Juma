import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juma/pages/app/appScaffold.dart';
import 'package:juma/pages/onboarding/welcomeScaffold.dart';
import 'package:provider/provider.dart';

class AppEntry extends StatefulWidget {
  @override
  _AppEntryState createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);

    if (user == null) {
      return WelcomeScaffold();
    }
    else {
      return AppScaffold();
    }
  }
}