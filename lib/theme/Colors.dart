import 'package:flutter/material.dart';

class JumaColors {
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

// TODO implement OrangeTheme and make it default in getTheme

class GreenTheme implements ColorTheme{
  ThemeType get type => ThemeType.gold;
  LinearGradient get gradient {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xffaafae0), Color(0xff59f2cc), Color(0xff59f2cc)],
      stops: [0.0, 0.4, 0.85]
    );
  }

  LinearGradient get accentGradient {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xFF1e3c72), Color(0xe61e3c72), Color(0x001e3c72)],
      stops: [0.0, 0.4, 0.6]
    );
  }

  Color get solid {
    return Color(0xff29db42);
  }

  Color get accent {
    return Color(0xff1e3c72);
  }
}

class RedTheme implements ColorTheme {
  ThemeType get type => ThemeType.red;
  LinearGradient get gradient {
    return LinearGradient(
      end: Alignment.bottomLeft,
      begin: Alignment.topRight,
      colors: [Color(0xffff934c), Color(0xfffc686f)],
      stops: [0.0, 0.85]
    );
  }

  LinearGradient get accentGradient {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xFF800107), Color(0xe6800107), Color(0x00800107)],
      stops: [0.0, 0.4, 0.6]
    );
  }

  Color get solid {
    return Color(0xffec1b25);
  }

  Color get accent {
    return Color(0xff800107);
  }
}

class PurpleTheme implements ColorTheme {
  ThemeType get type => ThemeType.purple;
  LinearGradient get gradient {
    return LinearGradient(
      end: Alignment.bottomLeft,
      begin: Alignment.topRight,
      colors: [Color(0xff7530e3), Color(0xffe1afcc)],
      stops: [0.0, 0.85]
    );
  }

  LinearGradient get accentGradient {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xFF43129c), Color(0xe643129c), Color(0x0043129c)],
      stops: [0.0, 0.4, 0.6]
    );
  }

  Color get solid {
    return Color(0xff823ef9);
  }

  Color get accent {
    return Color(0xff43129c);
  }
}

class GoldTheme implements ColorTheme {
  ThemeType get type => ThemeType.green;
  LinearGradient get gradient {
    return LinearGradient(
      end: Alignment.bottomLeft,
      begin: Alignment.topRight,
      colors: [Color(0xfff7cb6b), Color(0xfffba980)],
      stops: [0.0, 0.85]
    );
  }

  LinearGradient get accentGradient {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xFFcd9825), Color(0xe6cd9825), Color(0x00cd9825)],
      stops: [0.0, 0.4, 0.6]
    );
  }

  Color get solid {
    return Color(0xffecda17);
  }

  Color get accent {
    return Color(0xffcd9825);
  }
}

class BlackTheme implements ColorTheme {
  ThemeType get type => ThemeType.black;
  LinearGradient get gradient {
    return LinearGradient(
      end: Alignment.bottomLeft,
      begin: Alignment.topRight,
      colors: [Color(0xffe8f8f6), Color(0xfffaeafa)],
      stops: [0.0, 0.85]
    );
  }

  LinearGradient get accentGradient {
    return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [Color(0xFF0d0d0c), Color(0xe60d0d0c), Color(0x000d0d0c)],
      stops: [0.0, 0.4, 0.6]
    );
  }

  Color get solid {
    return Colors.black;
  }

  Color get accent {
    return Color(0xff0d0d0c);
  }
}

abstract class ColorTheme {
  LinearGradient get gradient;
  LinearGradient get accentGradient;
  Color get solid;
  Color get accent;
  ThemeType get type;

  static ColorTheme getTheme(ThemeType type) {
    switch (type) {
      case ThemeType.green: {
        return GreenTheme();
      }
      break;

      case ThemeType.red: {
        return RedTheme();
      }
      break;

      case ThemeType.purple: {
        return PurpleTheme();
      }
      break;

      case ThemeType.gold: {
        return GoldTheme();
      }
      break;

      case ThemeType.black: {
        return BlackTheme();
      }
      break;

      default: {
        return null;
      }
    }
  }

  static ColorTheme getLiftTheme(LiftTheme lift) {
    switch (lift) {
      case LiftTheme.squat: return RedTheme();
      case LiftTheme.bench: return GreenTheme();
      case LiftTheme.deadlift: return PurpleTheme();
      default: return null;
    }
  }
}

enum ThemeType {
  green,
  red,
  purple,
  gold,
  black
}

enum LiftTheme {
  squat,
  bench,
  deadlift
}