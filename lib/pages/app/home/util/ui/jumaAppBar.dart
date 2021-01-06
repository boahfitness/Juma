import 'package:flutter/material.dart';

class JumaAppBar extends AppBar {
  JumaAppBar() : super(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    elevation: 0,
    title: SizedBox(
      width: 55,
      height: 30,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            "JUMA",
            style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      )
    ),
  );
}

class EmptyAppBar extends AppBar {
  EmptyAppBar() : super(
    elevation: 0.0,
    backgroundColor: Colors.transparent
  );
}