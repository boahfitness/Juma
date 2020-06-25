import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:email_validator/email_validator.dart';

class InputCredentials extends StatefulWidget {
  final User user;
  final void Function(String email, String password) onDone;
  InputCredentials(this.user, {this.onDone});
  @override
  _InputCredentialsState createState() => _InputCredentialsState();
}

class _InputCredentialsState extends State<InputCredentials> {
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController verifyPassController;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    verifyPassController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    verifyPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text('Secure your account.'),
            ],
          ),
          SizedBox(height: 40,),
          TextFormField(
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
              if (value.length < 8) return 'minimum 8 characters';
              if (!value.contains(RegExp(r'[A-Z]'))) return 'At least one capital letter';
              if (!value.contains(RegExp(r'[0-9]'))) return 'At least one number';
              if (!value.contains(RegExp(r'[^\w.]'))) return 'At least one special character'; 
              return null;
            },
          ),
          TextFormField(
            controller: verifyPassController,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Verify Password',
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
              if (value != passwordController.text) return 'passwords do not match';
              return null;
            },
          ),
          SizedBox(height: 40,),
          FlatButton(
            onPressed: () {
              setState(() {
                if (formKey.currentState.validate()) {
                  widget.onDone(emailController.text, passwordController.text);
                }
                // TODO if email ends in udayton.edu or other school eamil, suggest to add to school team
              });
            },
            child: Text('Done', style: TextStyle(color: Colors.black),),
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          )
        ],
      ),
    );
  }
}