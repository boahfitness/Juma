import 'package:flutter/material.dart';
import 'package:juma/services/authService.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _authService = AuthService();

  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff211f1d),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 110, horizontal: 60),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/juma-logo-stroke-grad.png',
                  scale: 0.5,
                ),
                SizedBox( height: 30),
                Text(
                  'JUMA',
                  style: TextStyle(
                      color: Color(0xffee630f),
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox( height: 30 ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
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
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter email';
                    return null;
                  },
                ),
                SizedBox( height: 30),
                TextFormField(
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
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
                  validator: (value) {
                    if (value.isEmpty) return 'Please enter password';
                    return null;
                  },
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
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        print(email.text);
                        print(password.text);
                        var user = await _authService.signInAnon();
                        if (user == null) {
                          print('sign in error');
                        }
                        else {
                          print(user);
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}