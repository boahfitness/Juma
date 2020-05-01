import 'package:flutter/material.dart';
import 'package:juma/widgets/animatedStrokeLogo.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff2d2d2d), Color(0xff383838)],
          //stops: [0.0, 0.5],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft
        ),
      ),
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: MediaQuery.of(context).size.height / 2 - 100,
            left: MediaQuery.of(context).size.width / 2 - 100,
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              height: 200,
              width: 200,
              curve: Curves.easeInOut,
              child: AnimatedStrokeLogo(),
            ),
          )
        ],
      ),
    );
  }
}