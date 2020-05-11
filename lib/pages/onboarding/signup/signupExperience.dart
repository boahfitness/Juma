// to hold pageview that starts with welcome page and goes to signup scroller

import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/welcomePage.dart';

class SignupScroller extends StatefulWidget {
  @override
  _SignupScrollerState createState() => _SignupScrollerState();
}

class _SignupScrollerState extends State<SignupScroller> {

  PageController controller = PageController(initialPage: 0, keepPage: false);
  int currentIndex = 0;
  double uiOpacity;
  ScrollPhysics scrollPhysics;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    uiOpacity = currentIndex == 0 ? 0.0 : 1.0;
    scrollPhysics = currentIndex == 0 ? NeverScrollableScrollPhysics() : PageScrollPhysics();

    return Stack(
      children: <Widget>[
        PageView(
          onPageChanged: (val) {
            setState(() {
              currentIndex = val;
              if (val == 0) controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
            });
          },
          physics: scrollPhysics,
          controller: controller,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            WelcomePage(
              onSignup: () {
                setState(() {
                  controller.animateToPage(currentIndex + 1, duration: Duration(seconds: 1), curve: Curves.easeInOut);
                });
              },
            ),
            Container(
              child: Center(child: Text("Display Name"),),
            ),
            Container(child: Center(child: Text("PRs!"),),)
          ],
        ),

        //scroll UI: invisible on welcomePage
        AnimatedOpacity(
          opacity: uiOpacity,
          curve: Curves.linear,
          duration: Duration(milliseconds: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[Text("UI Controls")],
          ),
        ),
      ],
    );
  }
}