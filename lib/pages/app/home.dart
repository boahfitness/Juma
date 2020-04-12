import 'package:flutter/material.dart';
import 'package:juma/theme/Colors.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ColorTheme theme = ColorTheme.getTheme(ThemeType.gold);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return theme.gradient.createShader(bounds);
              },
              blendMode: BlendMode.color,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/sageNaruto.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: theme.accentGradient
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border(
            //       right: BorderSide(color: theme.solid, width: 6.0),
            //       left: BorderSide(color: theme.solid, width: 6.0)
            //     )
            //   ),
            // ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/juma-logo-stroke-grad.png', width: 75,),
                    Text("JUMA")
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("NEXT WORKOUT", style: wkText(),),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("SQUATS 5 X 5", style: wkText(),),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("RPE 7", style: wkText(),),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: theme.solid,
              ),
            ),
          ],
        ),
      )
    );
  }
}

TextStyle wkText() {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 40
  );
}