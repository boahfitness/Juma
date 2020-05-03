import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/pages.dart';
import 'dart:io';
import 'package:juma/theme/Colors.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<Page> pages;
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0, keepPage: false);

  @override
  void initState() {
    super.initState();
    pages = getPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        onPageChanged: (val) {
          setState(() {
            currentIndex = val;
          });
        },
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return pages[index];
        },
      ),
      // BOTTOM SHEET
      bottomSheet: currentIndex != pages.length -1 ? Container(
        color: JumaColors.boahOrange,
        height: Platform.isIOS ? 70 : 60,
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  // skip to signup here
                },
                child: Text("SKIP"),
              ),
              Row(
                children: <Widget>[
                  for(int i = 0; i < pages.length; i++) currentIndex == i ? PageIndexIndicator(true) : PageIndexIndicator(false)
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageController.jumpToPage(currentIndex + 1);
                  });
                },
                child: Text("NEXT"),
              )
            ],
          ),
        ),
      ) : GestureDetector(
        onTap: () {
          // go to signup
          print("LET'S GO!");
        },
        child: Container(
          height: Platform.isIOS ? 70 : 60,
          color: JumaColors.boahOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("LET'S GO!")
            ],
          ),
        ),
      ),
    );
  }
}

class PageIndexIndicator extends StatelessWidget {
  final bool isCurrent;
  PageIndexIndicator(this.isCurrent);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrent ? 10.0 : 8.0,
      width: isCurrent ? 10.0 : 8.0,
      decoration: BoxDecoration(
        color: isCurrent ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12)
      ),
      duration: Duration(seconds: 3),
      curve: Curves.bounceIn,
    );
  }
}