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
    return PageView.builder(
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
    );
  }
}