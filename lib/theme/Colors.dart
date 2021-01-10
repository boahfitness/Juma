import 'package:flutter/material.dart';

//https://material.io/resources/color/#!/?view.left=0&view.right=0&primary.color=00E676

class JumaColors {
  // Constant Brand Colors
  static Color get boahOrange { return Color(0xffee630f); }

  static Color get boahDarkGrey { return Color(0xff211f1d); }

  static Color get boahLightGrey { return Color(0xff2d2d2d); }

  static Color get darkRed { return Color(0xfffa3d03); }

  static Color get lightOrange {return Color(0xffd88a25); }

  static LinearGradient get redOrangeGradient {
    return LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [JumaColors.darkRed, JumaColors.boahOrange, JumaColors.lightOrange],
            stops: [0.0, 0.5, 0.9],
          );
  }

  static LinearGradient get lightGreyGradient {
    return LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff2d2d2d), Color(0xff383838)]
    );
  }
  
}

class ColorTheme {
  LinearGradient gradient;
  Color solid;
  Color accent; //up 2 [800]

  ColorTheme({@required this.gradient,
    @required this.solid,
    @required this.accent});
  
  /// to select the text color for the solid 
  Color get textColor {
    int threshold = 186; // can be adjusted for different results
    // anywhere from 150 to 200
    double value = solid.red * 0.299 + solid.green * 0.587 + solid.blue * 0.114;
    if (value > threshold) return Colors.black;
    else return Colors.white;
  }
}


/// defines constant color themes for Juma
abstract class ColorThemes {

  static ColorTheme _green = ColorTheme(
    solid: Colors.green,
    accent: Colors.cyan[800],
    gradient: LinearGradient(
      begin: Alignment.bottomLeft, end: Alignment.topRight,
      //colors: [Colors.greenAccent[400], Colors.tealAccent]
      colors: [Color(0xffaafae0), Color(0xff59f2cc), Color(0xff59f2cc)],
      stops: [0.0, 0.4, 0.85]
    ),
  );

  static ColorTheme get green => _green;

  static ColorTheme _red = ColorTheme(
    solid: Colors.red,
    accent: Colors.orange[800],
    gradient: LinearGradient(
      begin: Alignment.bottomLeft, end: Alignment.topRight,
      colors: [Colors.redAccent[400], Colors.deepOrangeAccent]
      //colors: [Color(0xffff934c), Color(0xfffc686f)],
    )
  );

  static ColorTheme get red => _red;

  static ColorTheme _blue = ColorTheme(
    solid: Colors.blue,
    accent: Colors.deepPurple[800],
    gradient: LinearGradient(
      begin: Alignment.bottomLeft, end: Alignment.topRight,
      colors: [Colors.blueAccent[400], Colors.indigoAccent],
    )
  );

  static ColorTheme get blue => _blue;

  static ColorTheme _purple = ColorTheme(
    solid: Colors.deepPurple,
    accent: Colors.pink[800],
    gradient: LinearGradient(
      begin: Alignment.bottomLeft, end: Alignment.topRight,
      colors: [Colors.deepPurpleAccent[400], Colors.purpleAccent]
    )
  );

  static ColorTheme get purple => _purple;

  static ColorTheme _gold = ColorTheme(
    solid: Colors.amber,
    accent: Colors.lime[800],
    gradient: LinearGradient(
      begin: Alignment.bottomLeft, end: Alignment.topRight,
      //colors: [Colors.amberAccent[400], Colors.yellowAccent[400]]
      colors: [Color(0xfff7cb6b), Color(0xfffba980)],
    )
  );

  static ColorTheme get gold => _gold;

  static ColorTheme _black = ColorTheme(
    solid: Colors.black,
    accent: Color(0xff0d0d0c),
    gradient: LinearGradient(
      begin: Alignment.bottomLeft, end: Alignment.topRight,
      colors: [Color(0xFF0d0d0c), Color(0xe60d0d0c), Color(0x000d0d0c)],
      stops: [0.0, 0.4, 0.6]
    )
  );

  static ColorTheme get black => _black;

  static ColorTheme _orange = ColorTheme(
    solid: Colors.deepOrange,
    accent: Colors.amber[800],
    gradient: LinearGradient(
      begin: Alignment.bottomLeft, end: Alignment.topRight,
      colors: [Colors.deepOrangeAccent, Colors.orangeAccent]
    )
  );

  static ColorTheme get orange => _orange;

  static List<ColorTheme> _themeList = [
    _green,
    _red,
    _purple,
    _gold,
    _black,
    _blue,
    _orange
  ];

  static List<ColorTheme> get themeList => _themeList;

  /// Gets the index of a predefinded Juma ColorTheme
  /// if theme is not found in Juma ColorThemes -1 is returned
  static int getIndex(ColorTheme theme) {
    return _themeList.indexWhere((element) {
      return element.solid == theme.solid &&
        element.accent == theme.accent &&
        element.gradient == theme.gradient;
    });
  }

  /// get a Juma ColorTheme by index
  /// if index is invalid, orange theme is returned
  static ColorTheme getThemeByIndex(int index) {
    if (index == null || index < 0 || index > _themeList.length - 1) {
      return _orange;
    }

    return _themeList[index];
  }

}

abstract class LiftThemes {
  static ColorTheme squat = ColorThemes.red;
  static ColorTheme bench = ColorThemes.green;
  static ColorTheme deadlift = ColorThemes.purple;
}