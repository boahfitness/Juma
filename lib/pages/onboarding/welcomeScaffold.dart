import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/login/login.dart';
import 'package:juma/pages/onboarding/onboarding.dart';
import 'package:juma/pages/onboarding/signup/signupScroller.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/theme/jumaIcons.dart';
import 'package:juma/widgets/animatedStrokeLogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScaffold extends StatefulWidget {
  @override
  _WelcomeScaffoldState createState() => _WelcomeScaffoldState();
}

class _WelcomeScaffoldState extends State<WelcomeScaffold> {

  bool showOnboarding = true;
  LogoState logoState = LogoState.center;
  double pageOpacity = 0.0;
  PageController controller;

  @override
  void initState() {
    checkFirstTime().then((value) => showOnboarding = value);
    //showOnboarding = true;
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: JumaColors.lightGreyGradient
        ),
        child: Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: pageOpacity,
              curve: Curves.linear,
              duration: Duration(milliseconds: 500),
              onEnd: () {
                if (pageOpacity == 0.0) {
                  setState(() {
                    pageOpacity = 1.0;
                    showOnboarding = !showOnboarding;
                  });
                }
              },
              child: showOnboarding ? Onboarding(onContinue: () => switchPage(),)
              :
              PageView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                controller: controller,
                children: <Widget>[
                  SignupScroller(
                    onStart: () {
                      setState(() {
                        logoState = LogoState.bottomLeft;
                      });
                    },
                    onReturnHome: () {
                      setState(() {
                        logoState = LogoState.center;
                      });
                    },
                    onLogin: () {
                      setState(() {
                        logoState = LogoState.midTopCenter;
                        controller.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
                      });
                    },
                  ),

                  Stack(
                    children: <Widget>[
                      Login(),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .05,
                        left: MediaQuery.of(context).size.width * .05,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              logoState = LogoState.center;
                              controller.previousPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
                            });
                          },
                          icon: Icon(JumaIcons.navLeft, color: Colors.white,),
                        ),
                      )
                    ],
                  )
                ],
              ), 
            ),
            AnimatedStrokeLogo(
              logoState: logoState,
              drawDone: () {
                setState(() {
                  if (showOnboarding) {
                    logoState = LogoState.topLeft;
                    Timer(Duration(seconds: 1), () {
                      pageOpacity = 1.0;
                    });
                  }
                  else {
                    pageOpacity = 1.0;
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }

  void switchPage() {
    setState(() {
      logoState = LogoState.center;
      pageOpacity = 0.0;
    });
  }

  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime') ?? true;

    if (firstTime) prefs.setBool('firstTime', false);

    return firstTime;
  }
}