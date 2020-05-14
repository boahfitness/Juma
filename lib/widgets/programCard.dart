import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/theme/Colors.dart';

class ProgramCard extends StatelessWidget {
  final Program program;
  final bool showTitle;
  final bool showAuthor;
  final bool showBorder;
  final bool usePicture;
  final ColorTheme customTheme;

  ProgramCard(this.program, 
    {this.showAuthor = true, this.showBorder = true, 
    this.showTitle = true, this.usePicture = true, this.customTheme});

  @override
  Widget build(BuildContext context) {
    bool _usePicture = (program.pathToPicture == null || program.pathToPicture.isEmpty)
      ? false : usePicture;

    ColorTheme theme = program.theme ?? ColorTheme.getTheme(null);
    theme = customTheme ?? theme;

    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Stack(
            children: <Widget>[
              // Main Gradient and Picture
              ShaderMask(
                shaderCallback: (Rect bounds) {
                  return theme.gradient.createShader(bounds);
                },
                blendMode: _usePicture ? BlendMode.color : BlendMode.src,
                child: _usePicture ? Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('${program.pathToPicture}'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.grey, BlendMode.saturation)
                    ),
                  ),
                ) : Container(color: Colors.transparent,),
              ),

              // Corner Accent Gradient
              Container(
                decoration: _usePicture ? BoxDecoration(
                  gradient: theme.accentGradient
                ) : BoxDecoration(color: Colors.transparent),
              ),

              // Optional Border
              Container(
                decoration: showBorder ? BoxDecoration(
                  border: Border.all(
                    color: theme.solid,
                    width: constraints.maxWidth * 0.0145
                  )
                ) : BoxDecoration(color: Colors.transparent),
              ),

              // Optional Title and Author
              Padding(
                padding: EdgeInsets.all(constraints.maxWidth * 0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded( flex: 10, child: Container(),),
                    Expanded(
                      flex: 3,
                      child: showTitle ? Text(program.title, style: cardText(constraints),) : Container(),
                    ),
                    Expanded(
                      flex: 3,
                      child: showAuthor ? Text(program.authorName, style: authText(constraints),) : Container(),
                    )
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}

TextStyle cardText(BoxConstraints constraints) {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: constraints.maxWidth * 0.084
  );
}

TextStyle authText(BoxConstraints constraints) {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
    fontSize: constraints.maxWidth * 0.056
  );
}