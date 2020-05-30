import 'package:flutter/material.dart';
import 'package:juma/widgets/auraPicker.dart';

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
      color: Colors.grey[700],
      child: Center(
        child: Container(
          width: 200,
          child: AuraPicker(
            text: 'HI',
            //theme: ColorTheme.getTheme(ThemeType.gold),
          ),
        ),
      ),
    );
  }
}