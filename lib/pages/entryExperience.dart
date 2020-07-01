import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juma/pages/app/appScaffold.dart';
import 'package:juma/pages/onboarding/welcomeScaffold.dart';
import 'package:provider/provider.dart';

class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
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