import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Image(
          image: AssetImage('assets/juma-logo-stroke-grad.png'),
        ),
      ),
    );
  }
}