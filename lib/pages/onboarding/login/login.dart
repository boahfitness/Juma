import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:juma/services/authService.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final formKey = GlobalKey<FormState>();
  TextEditingController emailController;
  TextEditingController passwordController;
  AuthService auth = AuthService();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 75.0),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Text('Login', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w100, fontSize: 20),),
            SizedBox(height: 40,),
            TextFormField(
              autocorrect: false,
              controller: emailController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'please enter email';
                if (!EmailValidator.validate(value)) return 'please enter valid email';
                return null;
              },
            ),
            TextFormField(
              autocorrect: false,
              controller: passwordController,
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'please enter password';
                return null;
              },
            ),
            SizedBox(height: 40,),
            FlatButton(
            onPressed: () async {
              if (formKey.currentState.validate()) {
                var x = await auth.signInWithEmailAndPassword(emailController.text, passwordController.text);
                if (x == null) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Container(
                        height: 50.0,
                        child: Center(
                          child: Text('Incorrect username or password', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                        )
                      ),
                    )
                  );
                }
              }
            },
            child: Text('Log In', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),),
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          )
          ],
        ),
      ),
    );
  }
}