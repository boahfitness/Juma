import 'package:juma/models/lifting/weight.dart';

class Exercise {
  String name;
  int sets;
  int reps;
  double rpe;
  Weight weight = Weight();
  Duration duration;
  Duration rest;
  double percentage;
  String coachNotes;
  String athleteNotes;
  DateTime completed;
  //String pathToVideo;

  double get workload {
    return weight.pounds * reps;
  }

  double get rpeWorkload {
    return weight.pounds * (reps + (10.0 - rpe));
  }

  Exercise({this.name, this.sets=0, this.reps=0, this.rpe=5.0,
    this.weight, this.duration, this.rest, this.percentage, 
    this.athleteNotes, this.coachNotes, this.completed});
}

abstract class MainLift extends Exercise {
  MainLiftDescriptor get descriptor;
}

class MainLiftDescriptor {
  String value;

  MainLiftDescriptor.fromLift(MainLift lift) {
    value = calculateDescriptor(lift);
  }

  MainLiftDescriptor() {
    value = '';
  }

  bool operator ==(dynamic other) {
    if (other.runtimeType == MainLiftDescriptor) {
      return value = other.value;
    }
    return false;
  }
  
  int get hashCode => super.hashCode;

  static String calculateDescriptor(MainLift lift) {
    String output = "";

    switch (lift.runtimeType) {

      case Squat: {
        Squat squat = lift;
        output += MainLiftType.squat.index.toString() + '-';
        output += squat.kneeEquipment.index.toString() + '-';
        output += squat.variation.index.toString() + '-';
        output += squat.suit.index.toString();
        return output;
      }

      case Bench: {
        Bench bench = lift;
        output += MainLiftType.bench.index.toString() + '-';
        output += bench.equipment.index.toString();
        return output;
      }

      case Deadlift: {
        Deadlift deadlift = lift;
        output += MainLiftType.deadlift.index.toString() + '-';
        output += deadlift.variation.index.toString() + '-';
        output += deadlift.equipment.index.toString();
        return output;
      }

      default: {
        return '';
      }

    } 
  }
}

enum MainLiftType {
  squat,
  bench,
  deadlift
}

class Squat extends MainLift {
  KneeEquipment kneeEquipment;
  SquatVariation variation;
  SquatSuit suit;
  MainLiftDescriptor _descriptor;

  @override
  String get name => 'Squat';

  bool operator ==(dynamic other) {
    if (other.runtimeType == Squat) {
      return kneeEquipment == other.kneeEquipment && variation == other.variation && suit == other.suit;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;

  @override
  MainLiftDescriptor get descriptor {
    _descriptor.value = MainLiftDescriptor.calculateDescriptor(this);
    return _descriptor;
  }
}
enum KneeEquipment {
  none,
  wraps
}
enum SquatSuit {
  none,
  breifs,
  suit
}
enum SquatVariation {
  highBar,
  lowBar
}

class Bench extends MainLift {
  BenchEquipment equipment;
  MainLiftDescriptor _descriptor;
  @override
  String get name => 'Bench';

  bool operator ==(dynamic other) {
    if (other.runtimeType == Bench) {
      return equipment == other.equipment;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;

  @override
  MainLiftDescriptor get descriptor {
    _descriptor.value = MainLiftDescriptor.calculateDescriptor(this);
    return _descriptor;
  }
}
enum BenchEquipment {
  none,
  slingshot,
  shirt
}

class Deadlift extends MainLift {
  DeadliftEquipment equipment;
  DeadliftVariation variation;
  MainLiftDescriptor _descriptor;

  @override
  String get name => 'Deadlift';

  bool operator ==(dynamic other) {
    if (other.runtimeType == Deadlift) {
      return equipment == other.equipment && variation == other.variation;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;

  @override
  MainLiftDescriptor get descriptor {
    _descriptor.value = MainLiftDescriptor.calculateDescriptor(this);
    return _descriptor;
  }
}
enum DeadliftEquipment {
  none,
  suit,
  breifs,
}

enum DeadliftVariation {
  sumo,
  conventional
}