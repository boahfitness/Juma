import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

class AnimatedStrokeLogo extends StatefulWidget {
  final double xpos, ypos, width;

  AnimatedStrokeLogo({this.xpos, this.ypos, this.width});

  @override
  _AnimatedStrokeLogoState createState() => _AnimatedStrokeLogoState();
}

class _AnimatedStrokeLogoState extends State<AnimatedStrokeLogo> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      top: widget.ypos,
      left: widget.xpos,
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: widget.width,
        width: widget.width,
        curve: Curves.easeInOut,
        child: FlareActor(
          'assets/video/jumaLightDrawThick.flr',
          animation: 'glowDraw',
        ),
      ),
    );
  }
}