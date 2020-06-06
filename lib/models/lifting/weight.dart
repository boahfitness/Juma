import 'package:flutter/material.dart';

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

  static Map<PoundPlateType, int> calculatePoundPlates(double targetWeight, {double barWeight = 45.0}) {
    //pound plates can only be calculated to the nearest 5
    // TODO implete calc pound plates

    double currentWeight = barWeight;
    List<PoundPlateType> plateTypes = PoundPlateType.values;

    plateTypes.forEach((plateType) {

    });

    return null;
  }

  static Map<KiloPlateType, int> calculateKiloPlates(double targetWeight, {double barWeight = 20.0}) {
    //kilo plates can only be calculated to the nearest 0.5
    // TODO implement calc kilo plates
    return null;
  }

}

enum WeightUnit {
  pounds,
  kilograms
}

abstract class Plates {
  double weight;
  double barWeight;
}

abstract class Plate {
  double weight;
}

class PoundPlates extends Plates {
  double _weight;
  double get weight => _weight;
  set weight(double val) {
    _weight = val;
    _plates = Weight.calculatePoundPlates(_weight, barWeight: _barWeight);
  }
  double _barWeight;
  double get barWeight => _barWeight;
  set barWeight(double val) {
    _barWeight = val;
    _plates = Weight.calculatePoundPlates(_weight, barWeight: _barWeight);
  }
  Map<PoundPlateType, int> _plates;
  Map<PoundPlateType, int> get plates => _plates;

  PoundPlates(double weight, {double barWeight=45.0}) {
    _weight = weight;
    _barWeight = barWeight;
    _plates = Weight.calculatePoundPlates(_weight, barWeight: _barWeight);
  }

  static PoundPlate fortyFive = PoundPlate(type: PoundPlateType.fortyfive, weight: 45.0);
  static PoundPlate twentyFive = PoundPlate(type: PoundPlateType.twentyfive, weight: 25.0);
  static PoundPlate ten = PoundPlate(type: PoundPlateType.ten, weight: 10.0);
  static PoundPlate five = PoundPlate(type: PoundPlateType.five, weight: 5.0);
  static PoundPlate twoFive = PoundPlate(type: PoundPlateType.twopointfive, weight: 2.5);

  static PoundPlate fromType(PoundPlateType type) {
    switch (type) {
      case PoundPlateType.fortyfive: return fortyFive;
      case PoundPlateType.twentyfive: return twentyFive;
      case PoundPlateType.ten: return ten;
      case PoundPlateType.five: return five;
      case PoundPlateType.twopointfive: return twoFive;
      default: return null;
    }
  }

}

enum PoundPlateType {
  fortyfive,
  twentyfive,
  ten,
  five,
  twopointfive
}

class PoundPlate extends Plate{
  PoundPlateType type;
  double weight;
  Color color;
  PoundPlate({this.type, this.weight, this.color=Colors.grey});
}

class KiloPlates extends Plates {
  double _weight;
  double get weight => _weight;
  set weight(double val) {
    _weight = val;
    _plates = Weight.calculateKiloPlates(_weight, barWeight: _barWeight);
  }

  double _barWeight;
  double get barWeight => _barWeight;
  set barWeight(double val) {
    _barWeight = val;
    _plates = Weight.calculateKiloPlates(_weight, barWeight: _barWeight);
  }

  Map<KiloPlateType, int> _plates;
  Map<KiloPlateType, int> get plates => _plates;

  KiloPlates(double weight, {double barWeight=20.0}) {
    _weight = weight;
    _barWeight = barWeight;
    _plates = Weight.calculateKiloPlates(_weight, barWeight: _barWeight);
  }

  static KiloPlate red = KiloPlate(type: KiloPlateType.red, weight: 25.0, color: Colors.red);
  static KiloPlate blue = KiloPlate(type: KiloPlateType.blue, weight: 20.0, color: Colors.blue);
  static KiloPlate yellow = KiloPlate(type: KiloPlateType.yellow, weight: 15.0, color: Colors.yellow);
  static KiloPlate green = KiloPlate(type: KiloPlateType.green, weight: 10.0, color: Colors.green);
  static KiloPlate white = KiloPlate(type: KiloPlateType.white, weight: 5.0, color: Colors.white);
  static KiloPlate black = KiloPlate(type: KiloPlateType.black, weight: 2.5, color: Colors.black);
  static KiloPlate one25 = KiloPlate(type: KiloPlateType.one25, weight: 1.25, color: Colors.grey);
  static KiloPlate zero5 = KiloPlate(type: KiloPlateType.zero5, weight: 0.5, color: Colors.grey);
  static KiloPlate zero25 = KiloPlate(type: KiloPlateType.zero25, weight: 0.25, color: Colors.grey);

  static KiloPlate fromType(KiloPlateType type) {
    switch(type){
      case KiloPlateType.red: return red;
      case KiloPlateType.blue: return blue;
      case KiloPlateType.yellow: return yellow;
      case KiloPlateType.green: return green;
      case KiloPlateType.white: return white;
      case KiloPlateType.black: return black;
      case KiloPlateType.one25: return one25;
      case KiloPlateType.zero5: return zero5;
      case KiloPlateType.zero25: return zero25;
      default: return null;
    }
  }

}

enum KiloPlateType {
  red,
  blue,
  yellow,
  green,
  white,
  black,
  one25,
  zero5,
  zero25
}

class KiloPlate extends Plate{
  KiloPlateType type;
  double weight;
  Color color;
  KiloPlate({this.type, this.weight, this.color});
}