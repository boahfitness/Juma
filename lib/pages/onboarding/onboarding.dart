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
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    pages = getPages();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
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
        SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("SKIP", style: TextStyle(color: JumaColors.boahOrange, fontSize: 12),),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for(int i = 0; i < pages.length; i++) currentIndex == i ? PageIndexIndicator(true) : PageIndexIndicator(false)
                  ],
                ),
              ),
            ],
          ),
        )
      ],
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
      height: 12.0,
      width: 12.0,
      decoration: BoxDecoration(
        color: isCurrent ? JumaColors.boahOrange : Colors.grey[900],
        borderRadius: BorderRadius.circular(12)
      ),
      duration: Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }
}