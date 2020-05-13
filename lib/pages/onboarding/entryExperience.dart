// wrapper for onboarding and welcomePage

// return welcome page or onboarding depending on bool with logo automatically on top in stack

// this is done so that welcomepage can control its own animation and so that switching order is easier

// this widget might also need to control the signup experience

// needs to have functionality just for switching between then with a fade (switch case)

import 'dart:async';
import 'package:juma/pages/onboarding/signup/signupExperience.dart';
import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/pages/app/home.dart';
import 'package:juma/pages/onboarding/onboarding.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/widgets/animatedStrokeLogo.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Entry extends StatefulWidget {
  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {

  bool showOnboarding;
  
  LogoState logoState = LogoState.center;

  double pageOpacity = 0.0;

  @override
  void initState() {
    //showOnboarding = await checkFirstTime();
    showOnboarding = true;
    super.initState();

    Timer(Duration(seconds: 3,), () {
      setState(() {
        logoState = LogoState.topLeft;
      });
    });

    Timer(Duration(seconds: 4,), () {
      setState(() {
        pageOpacity = 1.0;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    if (user == null) {
      return Scaffold(
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
                ),
              ),
              AnimatedStrokeLogo(logoState: logoState,)
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

    if (firstTime) {
      prefs.setBool('firstTime', false);
    }

    return firstTime;
  }
}