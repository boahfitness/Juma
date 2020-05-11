import 'package:flutter/material.dart';
import 'package:juma/pages/onboarding/pageIndexIndicator.dart';

class ScrollUI extends StatefulWidget {

  final double uiOpacity;
  final int currentIndex;
  final int numPages;
  final void Function() onTapUp;
  final void Function() onTapDown;
  ScrollUI({this.uiOpacity, this.currentIndex, this.numPages, this.onTapUp, this.onTapDown});

  @override
  _ScrollUIState createState() => _ScrollUIState();
}

class _ScrollUIState extends State<ScrollUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: SafeArea(
        child: AnimatedOpacity(
          opacity: widget.uiOpacity,
          curve: Curves.linear,
          duration: Duration(milliseconds: 500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    height: widget.numPages * 13.33,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        for (int i = 1; i < widget.numPages; i++) widget.currentIndex == i ? PageIndexIndicator(true, 8.0) : PageIndexIndicator(false, 8.0)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: widget.onTapUp,
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.grey[100],
                            size: 40,
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.onTapDown,
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: widget.currentIndex != widget.numPages - 1 ? Colors.grey[100] : Colors.grey[800],
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}