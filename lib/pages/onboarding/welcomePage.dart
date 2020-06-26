import 'package:flutter/material.dart';
import 'package:juma/theme/Colors.dart';

class WelcomePage extends StatefulWidget {

  final void Function() onJoinPressed;
  final void Function() onLoginPressed;

  WelcomePage({this.onJoinPressed, this.onLoginPressed});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin{

  AnimationController welcomeController;
  Animation<double> buttonAnim;
  Animation<double> titleAnim;
  Animation<double> taglineAnim;

  @override
  void initState() {
    super.initState();

    welcomeController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this
    );

    titleAnim = CurvedAnimation(
      curve: Interval(
        0.5, 0.8,
        curve: Curves.bounceOut
      ),
      parent: welcomeController
    )
    ..addListener(() {
      setState(() {});
    });

    buttonAnim = CurvedAnimation(
      curve: Interval(
        0.6, 0.9,
        curve: Curves.bounceOut
      ), 
      parent: welcomeController
    )
    ..addListener(() {
      setState(() {});
    });

    taglineAnim = CurvedAnimation(
      curve: Interval(
        0.7, 1.0,
        curve: Curves.linear,
      ),
      parent: welcomeController
    )
    ..addListener(() {
      setState(() {});
    });

    welcomeController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: <Widget>[
          SizedBox(height: screenHeight/7,),
          Transform.scale(
            scale: titleAnim.value,
            alignment: Alignment.bottomCenter,
            child: Text(
              "WELCOME TO",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Transform.scale(
            scale: titleAnim.value,
            alignment: Alignment.topCenter,
            child: Text(
              "JUMA",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Opacity(
            opacity: taglineAnim.value,
            child: Text(
              "Strength Training Redesigned",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: JumaColors.boahOrange,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(height: screenHeight/2.1,),
          Transform.scale(
            scale: buttonAnim.value,
            alignment: Alignment.center,
            child: SizedBox(
              width: 280,
              height: 60,
              child: RaisedButton(
                child: Text("JOIN THE GANG!", style: TextStyle(fontWeight: FontWeight.bold, color: JumaColors.boahDarkGrey, fontSize: 18),),
                onPressed: () {
                  widget.onJoinPressed();
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                //color: JumaColors.boahDarkGrey,
                color: Colors.white,
                elevation: 10.0,
              ),
            ),
          ),
          SizedBox(height: 20,),
          Opacity(
            opacity: taglineAnim.value,
            child: GestureDetector(
              onTap: widget.onLoginPressed,
              child: Column(
                children: <Widget>[
                  Text(
                    "I ALREADY HAVE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      //decoration: TextDecoration.underline
                    ),
                  ),
                  Text(
                    "AN ACCOUNT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      //decoration: TextDecoration.underline
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    welcomeController.dispose();
    super.dispose();
  }

}