import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
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
    User user = Provider.of<User>(context);

    if (user == null) {
      return WelcomeScaffold();
    }
    else {
      return AppScaffold();
    }
  }
}