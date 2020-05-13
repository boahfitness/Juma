import 'package:juma/models/lifting/weight.dart';

class Exercise {
  MainLiftType mainLiftType;
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

  Exercise({this.mainLiftType, this.name, this.sets=0, this.reps=0, this.rpe=5.0,
    this.weight, this.duration, this.rest, this.percentage, 
    this.athleteNotes, this.coachNotes, this.completed});
}

enum MainLiftType {
  squat,
  squatWrapped,
  squatSuit,
  squatWrappedSuit,
  bench,
  benchShirt,
  deadliftConv,
  deadliftConvSuit,
  deadliftSumo,
  deadliftSumoSuit,
}