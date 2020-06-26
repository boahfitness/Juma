import 'package:flutter/material.dart';
import 'package:juma/services/authService.dart';
import 'package:provider/provider.dart';
import 'package:juma/models/users/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) Navigator.of(context).pushReplacementNamed('/');

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text('Profile', style: TextStyle(fontFamily: 'Oswald'),)
      ),

      body: Center(child: Text('PROFILE: ${user.displayName}'),),

      drawer: Drawer(
        child: FlatButton(
          child: Text('Sign Out'),
          onPressed: () {
            AuthService().signOut();
          },
        ),
      ),
    );
  }
}