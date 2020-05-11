import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class AnimatedStrokeLogo extends StatefulWidget {
  final LogoState logoState;

  AnimatedStrokeLogo({this.logoState});

  @override
  _AnimatedStrokeLogoState createState() => _AnimatedStrokeLogoState();
}

class _AnimatedStrokeLogoState extends State<AnimatedStrokeLogo> {

  double xpos, ypos, width;

  void calculatePos(LogoState state) {
    switch (state) {
      case LogoState.center: {
        width = 200;
        xpos = MediaQuery.of(context).size.width / 2 - (width / 2);
        ypos = MediaQuery.of(context).size.height / 2 - (width / 2);
      }
        break;
      case LogoState.topLeft: {
        width = 100;
        xpos = MediaQuery.of(context).size.width * 0.05;
        ypos = MediaQuery.of(context).size.height * 0.05;
      }
        break;
      case LogoState.bottomLeft: {
        width = 100;
        xpos = MediaQuery.of(context).size.width * 0.05;
        ypos = MediaQuery.of(context).size.height * 0.95;
      }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {

    calculatePos(widget.logoState);

    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      top: ypos,
      left: xpos,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: width,
        width: width,
        curve: Curves.easeInOut,
        child: FlareActor(
          'assets/video/jumaLightDrawThick.flr',
          animation: 'glowDraw',
        ),
      ),
    );
  }
}

enum LogoState {
  center,
  topLeft,
  bottomLeft,
}