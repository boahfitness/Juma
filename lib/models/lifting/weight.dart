class Weight {
  double pounds;
  double kilograms;

  Weight({this.pounds, this.kilograms}) {
    if (pounds == null && kilograms == null) {
      pounds = kilograms = 0;
    }
    else {

    }
  }

  static double poundsToKilos(double pounds) {
    return pounds / 2.205;
  }

  static kilosToPounds(double kilos) {
    return kilos * 2.205;
  }

  static PoundPlates calculatePoundsPlates(double pounds, {double barWeight = 45}) {
    // TODO implete calc pound plates

    // method: subtract barweight and round input to nearest 5
    //keep adding 45 till get over weight then go back
    //keep adding 25s till get over then go back;
    //ans so on.. until hit weight
  }

  static KiloPlates calculateKiloPlates(double kilos, {double barWeight = 20}) {
    // TODO implement calc kilo plates
  }

}

class PoundPlates {
  double weight;
  int num45s;
  int num25s;
  int num10s;
  int num5s;
  int num2point5s;
}

class KiloPlates {
  double weight;
  int numRed;
  int numBlue;
  int numYellow;
  int numGreen;
  int numWhite;
  int numBlack;
  int numSilver;
  int numPoint5;
  int numChip;
}