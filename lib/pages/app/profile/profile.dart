import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/services/googleSheetsService.dart';
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

    return user != null ? Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: Text('Profile', style: TextStyle(fontFamily: 'Oswald'),)
      ),

      body: Center(child: Text('PROFILE: ${user.displayName}'),),

      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              child: Text('Sign Out'),
              onPressed: () {
                AuthService().signOut();
              },
            ),
            FlatButton(
              child: Text('CREATE PROGRAM TEST'),
              onPressed: () {
                //GoogleSheetsService gsService = GoogleSheetsService(); // google sheet service for creating the spreadhseet and stuff
                var firebaseUser = user.firebase;

                if (firebaseUser == null) {
                  print("NULL firebase User!!");
                  return;
                }

                UserInfo googleProvider = firebaseUser.providerData.firstWhere((provider) => provider.providerId == GoogleAuthProvider.providerId, 
                  orElse: () => null);

                // In this case we should have two pop ups? one for prompt to create program
                // and one that says the user is not a google user and what to do next
                if (googleProvider != null) {
                  //gsService.createSpreadsheet(firebaseUser.email);
                  print("Google user ${firebaseUser.email}");
                }
                else {
                  print("NOT Google user ${firebaseUser.email}");
                }
              },
            )
          ],
        ),
      ),
    )
    :
    Container();
  }
}