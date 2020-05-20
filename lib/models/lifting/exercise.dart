import 'package:juma/models/lifting/weight.dart';

class Exercise {
  String name;
  int sets;
  int reps;
  Weight weight = Weight();
  Duration rest;
  String coachNotes;
  String athleteNotes;
  DateTime completed;
  //String pathToVideo;

  double get workload {
    return weight.pounds * reps;
  }

  Exercise({this.name, this.sets=0, this.reps=0,
    this.weight, this.rest,
    this.athleteNotes, this.coachNotes, this.completed});
}

class DurationExercise extends Exercise {
  Duration duration;

  double get workload => null;
}

abstract class MainLift extends Exercise {
  double percentage;
  double rpe;
  bool isPR;
  MainLiftDescriptor get descriptor;

  double get rpeWorkload {
    return weight.pounds * (reps + (10.0 - rpe));
  }
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
      return value == other.value;
    }
    return false;
  }
  
  int get hashCode => super.hashCode;

  @override
  String toString() {
    return value;
  }

  static String calculateDescriptor(MainLift lift) {
    String output = "";

    switch (lift.runtimeType) {

      case Squat: {
        Squat squat = lift;
        output += MainLiftType.squat.index.toString() + '-';
        output += squat.kneeEquipment.index.toString() + '-';
        output += squat.variation.index.toString() + '-';
        output += squat.equipment.index.toString();
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
  SquatEquipment equipment;
  MainLiftDescriptor _descriptor;

  Squat({this.kneeEquipment=KneeEquipment.none, this.variation=SquatVariation.lowBar, this.equipment=SquatEquipment.raw}) {
    _descriptor = MainLiftDescriptor.fromLift(this);
  }

  @override
  String get name => 'Squat';

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
enum SquatEquipment {
  raw,
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

  Bench({this.equipment=BenchEquipment.raw}) {
    _descriptor = MainLiftDescriptor.fromLift(this);
  }

  @override
  String get name => 'Bench';

  @override
  MainLiftDescriptor get descriptor {
    _descriptor.value = MainLiftDescriptor.calculateDescriptor(this);
    return _descriptor;
  }
}
enum BenchEquipment {
  raw,
  slingshot,
  shirt
}

class Deadlift extends MainLift {
  DeadliftEquipment equipment;
  DeadliftVariation variation;
  MainLiftDescriptor _descriptor;

  Deadlift({this.equipment=DeadliftEquipment.raw, this.variation=DeadliftVariation.conventional}) {
    _descriptor = MainLiftDescriptor.fromLift(this);
  }

  @override
  String get name => 'Deadlift';

  @override
  MainLiftDescriptor get descriptor {
    _descriptor.value = MainLiftDescriptor.calculateDescriptor(this);
    return _descriptor;
  }
}
enum DeadliftEquipment {
  raw,
  suit,
  breifs,
}

enum DeadliftVariation {
  sumo,
  conventional
}