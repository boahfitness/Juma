import 'package:flutter/material.dart';
import 'package:juma/services/authService.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text('Profile', style: TextStyle(fontFamily: 'Oswald'),)
      ),

      body: Center(child: Text('PROFILE'),),

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