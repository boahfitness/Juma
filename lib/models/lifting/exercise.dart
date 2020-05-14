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
  @override
  String get name => 'Squat';
}
enum SquatEquipment {
  wraps,
  suit,
  breifs
}

class Bench extends MainLift {
  Set<BenchEquipment> equipment = new Set();
  @override
  String get name => 'Bench';
}
enum BenchEquipment {
  slingshot,
  shirt
}

class Deadlift extends MainLift {
  Set<DeadliftEquipment> equipment = new Set();
  @override
  String get name => 'Deadlift';
}
enum DeadliftEquipment {
  suit,
  breifs,
}