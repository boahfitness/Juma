import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/pages.dart';
import 'package:juma/theme/Colors.dart';

class Onboarding extends StatefulWidget {

  final void Function() onContinue;

  Onboarding({this.onContinue});

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
                child: GestureDetector(
                  onTap: () {
                    widget.onContinue();
                  },
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
                    for(int i = 0; i < pages.length; i++) currentIndex == i ? PageIndexIndicator(true) : PageIndexIndicator(false)
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
                      width: 70.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (currentIndex != 0) {
                                setState(() {
                                  pageController.animateToPage(currentIndex - 1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                });
                              }
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: currentIndex != 0 ? Colors.grey[100] : Colors.grey[800],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (currentIndex != pages.length - 1) {
                                setState(() {
                                  pageController.animateToPage(currentIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                                });
                              }
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: currentIndex != pages.length - 1 ? Colors.grey[100] : Colors.grey[800],
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