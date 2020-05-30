import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/pages/onboarding/welcomePage.dart';
import 'package:juma/pages/onboarding/signup/signupScrollUI.dart';

import 'package:juma/pages/onboarding/signup/inputPages/displayName.dart';
import 'package:juma/pages/onboarding/signup/inputPages/enterMaxes.dart';

class SignupScroller extends StatefulWidget {

  final void Function() onStart;
  final void Function() onReturnHome;

  SignupScroller({this.onStart, this.onReturnHome});

  @override
  _SignupScrollerState createState() => _SignupScrollerState();
}

class _SignupScrollerState extends State<SignupScroller> {

  User user = User();

  PageController pageController = PageController(initialPage: 0, keepPage: false);

  int currentIndex = 0;
  double uiOpacity;
  ScrollPhysics scrollPhysics;
  bool upDisabled = false, downDisabled = false;

  final displayName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    displayName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    uiOpacity = currentIndex == 0 ? 0.0 : 1.0;
    //scrollPhysics = currentIndex == 0 ? NeverScrollableScrollPhysics() : NeverScrollableScrollPhysics();
    scrollPhysics = NeverScrollableScrollPhysics();

    List<Widget> pages = [
      WelcomePage(
        onJoinPressed: () {
          setState(() {
            pageController.animateToPage(currentIndex + 1, duration: Duration(seconds: 1), curve: Curves.easeInOut);
            widget.onStart();
          });
        },
      ),
      InputDisplayName(displayName),
      EnterMaxes(user),
    ];

    int numPages = pages.length;

    return Form(
      key: formKey,
      child: Stack(
        children: <Widget>[
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w100,
              fontSize: 20,
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .1),
              child: PageView.builder(
                onPageChanged: (val) {
                  setState(() {
                    currentIndex = val;
                    if (val == 0) {
                      widget.onReturnHome();
                      pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                    }
                  });
                },
                physics: scrollPhysics,
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: numPages,
                itemBuilder: (context, index) {
                  return pages[index];
                },
              ),
            ),
          ),

          //scroll UI: invisible on welcomePage
          ScrollUI(uiOpacity: uiOpacity, currentIndex: currentIndex, numPages: numPages,
            onTapUp: () {
              if (currentIndex != 0 && !upDisabled) {
                Duration dur = currentIndex == 1 ? Duration(milliseconds: 1000) : Duration(seconds: 1);
                setState(() {
                  pageController.previousPage(duration: dur, curve: Curves.easeInOut);
                });
              }
            },
            onTapDown: () {
              if (currentIndex != 0 && currentIndex != numPages - 1 && !downDisabled && formKey.currentState.validate()) {
                setState(() {
                  pageController.nextPage(duration: Duration(seconds: 1), curve: Curves.easeInOut);
                });
              }
            },
          ),
        ],
      ),
    );
  }
}