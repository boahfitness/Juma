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
}

class Squat extends MainLift {
  Set<SquatEquipment> equipment = new Set();
  SquatVariation variation = SquatVariation.lowBar;
  @override
  String get name => 'Squat';

  bool operator ==(dynamic other) {
    if (other.runtimeType == Squat) {
      return equipment.containsAll(other.equipment) && equipment.length == other.equipment.length && variation == other.variation;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode => equipment.hashCode;
}
enum SquatEquipment {
  wraps,
  suit,
  breifs
}
enum SquatVariation {
  highBar,
  lowBar
}

class Bench extends MainLift {
  Set<BenchEquipment> equipment = new Set();
  @override
  String get name => 'Bench';

  bool operator ==(dynamic other) {
    if (other.runtimeType == Bench) {
      return equipment.containsAll(other.equipment) && equipment.length == other.equipment.length;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode => equipment.hashCode;
}
enum BenchEquipment {
  slingshot,
  shirt
}

class Deadlift extends MainLift {
  Set<DeadliftEquipment> equipment = new Set();
  DeadliftVariation variation = DeadliftVariation.conventional;

  @override
  String get name => 'Deadlift';

  bool operator ==(dynamic other) {
    if (other.runtimeType == Deadlift) {
      return equipment.containsAll(other.equipment) && equipment.length == other.equipment.length && variation == other.variation;
    }
    else {
      return false;
    }
  }

  @override
  int get hashCode => super.hashCode;
}
enum DeadliftEquipment {
  suit,
  breifs,
}

enum DeadliftVariation {
  sumo,
  conventional
}