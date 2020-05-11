import 'package:flutter/material.dart';
import 'package:juma/services/authService.dart';

final AuthService _authService = AuthService();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      backgroundColor: Color(0xff211f1d),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Transform.translate(
              offset: Offset(0.0, -30.0),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 60),
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/juma-logo-stroke-grad.png'),
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
                              LoginInput(controller: email, label: "Email", type: TextInputType.emailAddress,),
                              SizedBox( height: 30),
                              LoginInput(controller: password, label: "Password", hideText: true, type: TextInputType.visiblePassword,),
                              SizedBox(height: 30),
                              LoginButton(formKey: formKey, password: password, email: email)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// HELPERS
class LoginButton extends StatelessWidget {

  final double width;
  final double height;
  final TextEditingController email;
  final TextEditingController password;
  final GlobalKey<FormState> formKey;

  LoginButton({
    this.width = 700, 
    this.height = 60,
    this.email,
    this.password,
    this.formKey
  });

  @override 
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
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
    );
  }
}

class LoginInput extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final TextInputType type;
  final bool hideText;

  LoginInput({this.controller, this.label, this.type, this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: hideText,
      style: TextStyle(
        color: Colors.white,
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: label,
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
        if (value.isEmpty) return 'Please enter ${label.toLowerCase()}';
        return null;
      },
    );
  }
}

enum InputType {
  email,
  password
}