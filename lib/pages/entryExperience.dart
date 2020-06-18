// wrapper for onboarding and welcomePage

// return welcome page or onboarding depending on bool with logo automatically on top in stack

// this is done so that welcomepage can control its own animation and so that switching order is easier

// this widget might also need to control the signup experience

// needs to have functionality just for switching between then with a fade (switch case)

import 'dart:async';
import 'package:juma/pages/onboarding/signup/signupScroller.dart';
import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/onboarding/onboarding.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/theme/jumaIcons.dart';
import 'package:juma/widgets/animatedStrokeLogo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:juma/pages/onboarding/login/login.dart';

class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {

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
    User user = Provider.of<User>(context);

    if (user == null) {
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
                child: showOnboarding ? Onboarding(onContinue: () {
                  switchPage();
                },) 
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
              AnimatedStrokeLogo(logoState: logoState, 
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
    else {
      return Home();
    }
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

    print('first time? $firstTime');

    if (firstTime) {
      prefs.setBool('firstTime', false);
    }

    return firstTime;
  }
}