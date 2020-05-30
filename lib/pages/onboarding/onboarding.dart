import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/onboardingPages.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/pages/onboarding/pageIndexIndicator.dart';
import 'package:juma/theme/jumaIcons.dart';

class Onboarding extends StatefulWidget {

  final void Function() onContinue;

  Onboarding({this.onContinue});

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<OnboardingPage> pages;
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
                padding: const EdgeInsets.all(10.0),
                child: FlatButton(
                  onPressed: widget.onContinue,
                  child: Text("SKIP", style: TextStyle(color: JumaColors.boahOrange, fontSize: 12),)
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: currentIndex != pages.length - 1 ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for(int i = 0; i < pages.length; i++) currentIndex == i ? PageIndexIndicator(true, 12.0) : PageIndexIndicator(false, 12.0)
                  ],
                )
                :
                Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 300,
                    child: RaisedButton(
                      onPressed: () {
                        widget.onContinue();
                      },
                      child: Text("Get Started", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.white),),
                      color: JumaColors.boahOrange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SafeArea(
          child: currentIndex != pages.length -1 ? Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 80.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: IconButton(
                              onPressed: () {
                                if (currentIndex != 0) {
                                  setState(() {
                                    pageController.animateToPage(currentIndex - 1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                  });
                                }
                              },
                              color: currentIndex != 0 ? Colors.grey[100] : Colors.grey[800],
                              iconSize: 20,
                              alignment: Alignment.center,
                              icon: Icon(
                                JumaIcons.navLeft,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 35,
                            height: 35,
                            child: IconButton(
                              onPressed: () {
                                if (currentIndex != pages.length - 1) {
                                  setState(() {
                                    pageController.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                  });
                                }
                              },
                              color: currentIndex != pages.length - 1 ? Colors.grey[100] : Colors.grey[800],
                              iconSize: 20,
                              alignment: Alignment.center,
                              icon: Icon(
                                JumaIcons.navRight,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ) : SizedBox(),
        ),
      ],
    );
  }
}