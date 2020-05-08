import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/widgets/animatedStrokeLogo.dart';
import 'package:juma/pages/onboarding/onboarding.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin{

  AnimationController animController;
  Animation<double> buttonAnim;
  Animation<double> titleAnim;
  Animation<double> taglineAnim;

  bool showWelcome = true;
  double pageOpacity = 1.0;

  double logoPosx;
  double logoPosy;
  double logoWidth = 200;
  bool centerLogo = true;

  @override
  void initState() {
    super.initState();
    animController = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this
    );

    buttonAnim = CurvedAnimation(
      curve: Interval(
        0.8, 0.95,
        curve: Curves.bounceOut
      ), 
      parent: animController
    )
    ..addListener(() {
      setState(() {});
    });

    titleAnim = CurvedAnimation(
      curve: Interval(
        0.75, 0.9,
        curve: Curves.bounceOut
      ),
      parent: animController
    )
    ..addListener(() {
      setState(() {});
    });

    taglineAnim = CurvedAnimation(
      curve: Interval(
        0.85, 1.0,
        curve: Curves.linear,
      ),
      parent: animController
    )
    ..addListener(() {
      setState(() {});
    });

    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    double centerx = MediaQuery.of(context).size.width / 2 - (logoWidth / 2);
    double centery = MediaQuery.of(context).size.height / 2 - (logoWidth / 2);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (centerLogo) {
      logoPosx = centerx;
      logoPosy = centery;
    }
    else {
      logoPosx = screenWidth * .05;
      logoPosy = screenHeight * .05;
    }

    //what if this widget is onboarding but hidden and fades into it with logo still in tact
    // if not logged in then show welcome page
    if (user == null) {
      return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: JumaColors.lightGreyGradient
            //color: Colors.black
          ),
          child: Stack(
            children: <Widget>[
              AnimatedOpacity(
                opacity: pageOpacity,
                curve: Curves.linear,
                duration: Duration(milliseconds: 500),
                onEnd: () {
                  setState(() {
                    if (pageOpacity == 0.0) {
                      showWelcome = !showWelcome;
                      pageOpacity = 1.0;
                    }
                  });
                },
                child: showWelcome ? Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: screenHeight/5,),
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
                            color: JumaColors.boahOrange
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight/2.5,),
                      Transform.scale(
                        scale: buttonAnim.value,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 300,
                          height: 60,
                          child: RaisedButton(
                            child: Text("JOIN THE GANG!", style: TextStyle(fontWeight: FontWeight.bold, color: JumaColors.boahDarkGrey, fontSize: 20),),
                            onPressed: () {
                              setState(() {
                                //opacity animation automattically switches the page
                                pageOpacity = 0;
                                logoWidth = logoWidth / 2;
                                centerLogo = false;
                              });
                            },
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            //color: JumaColors.boahDarkGrey,
                            color: Colors.white,
                            elevation: 0.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Opacity(
                        opacity: taglineAnim.value,
                        child: GestureDetector(
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
                ) 
                : 
                Onboarding(),
              ),
              AnimatedStrokeLogo(xpos: logoPosx, ypos: logoPosy, width: logoWidth,),
            ],
          ),
        ),
      );
    }
    // else return app *this return is done so that it will return here on logoff*
    else 
    {
      return Home();
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

}