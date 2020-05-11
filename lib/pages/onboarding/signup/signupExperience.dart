// to hold pageview that starts with welcome page and goes to signup scroller

import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/welcomePage.dart';
import 'package:juma/pages/onboarding/signup/signupScrollUI.dart';

class SignupScroller extends StatefulWidget {

  final void Function() onStart;
  final void Function() onReturnHome;

  SignupScroller({this.onStart, this.onReturnHome});

  @override
  _SignupScrollerState createState() => _SignupScrollerState();
}

class _SignupScrollerState extends State<SignupScroller> {

  PageController controller = PageController(initialPage: 0, keepPage: false);
  int currentIndex = 0;
  double uiOpacity;
  ScrollPhysics scrollPhysics;
  final int numPages = 3;

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
              if (val == 0) {
                widget.onReturnHome();
                controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
              }
            });
          },
          physics: scrollPhysics,
          controller: controller,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            WelcomePage(
              onJoinPressed: () {
                setState(() {
                  controller.animateToPage(currentIndex + 1, duration: Duration(seconds: 1), curve: Curves.easeInOut);
                  widget.onStart();
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
        ScrollUI(uiOpacity: uiOpacity, currentIndex: currentIndex, numPages: numPages,
          onTapUp: () {
            if (currentIndex != 0) {
              Duration dur = currentIndex == 1 ? Duration(milliseconds: 500) : Duration(seconds: 1);
              setState(() {
                controller.previousPage(duration: dur, curve: Curves.linear);
              });
            }
          },
          onTapDown: () {
            if (currentIndex != 0 && currentIndex != numPages - 1) {
              setState(() {
                controller.nextPage(duration: Duration(seconds: 1), curve: Curves.linear);
              });
            }
          },
        ),
      ],
    );
  }
}