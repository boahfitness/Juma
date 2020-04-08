import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Login(),
      },
    ));

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "Email";
  String password = "Password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff211f1d),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // TODO change to expanded flex instad of sizedbox separation
          children: <Widget>[
            Image.asset(
              'assets/juma-logo-stroke-grad.png',
              scale: 0.5,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'JUMA',
              style: TextStyle(
                  color: Color(0xffee630f),
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Color(0xffee630f),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Color(0xffee630f),
                    width: 2.0
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Color(0xffee630f),
                    width: 2.0
                  ),
                ),
                hasFloatingPlaceholder: true,
              ),
            ),
            SizedBox(height: 30),
            TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(
                  color: Color(0xffee630f),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Color(0xffee630f),
                    width: 2.0
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: Color(0xffee630f),
                    width: 2.0
                  ),
                ),
                hasFloatingPlaceholder: true,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 700,
              height: 60,
              child: FlatButton(
                color: Colors.grey[700],
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Color(0xffee630f),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
