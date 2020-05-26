class Weight {

  // Variables
  double _pounds, _kilograms;

  double get pounds {
    return _pounds;
  }
  set pounds(double val) {
    _pounds = val;
    _kilograms = poundsToKilos(val);
  }

  double get kilograms {
    return _kilograms;
  }
  set kilograms(double val) {
    _kilograms = val;
    _pounds = kilosToPounds(val);
  }

  // Constructors
  Weight.kilograms(double val) {
    kilograms = val;
  }

  Weight.pounds(double val) {
    pounds = val;
  }

  Weight() {
    pounds = 0.0;
  }
  
  // Methods
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

enum WeightUnit {
  pounds,
  kilograms
}

abstract class Plates {
  Weight weight;
  double barWeight;
}

class PoundPlates extends Plates {
  Weight weight;
  double barWeight = 45.0;
  int num45s;
  int num25s;
  int num10s;
  int num5s;
  int num2point5s;
}

class KiloPlates extends Plates {
  Weight weight;
  double barWeight = 20.0;
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