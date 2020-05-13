import 'package:juma/models.bak/program.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  List<PR> personalRecords;

  Program currentProgram;

  List<Program> pastPrograms;

  User({this.uid});

  User.test() {
    uid = "fghfjrtdhtfhfnaffndhky";
    firstName = "Kevin";
    lastName = "Yeboah";
    currentProgram = Program.test();

    pastPrograms = List<Program>();
    pastPrograms.addAll([
      Program.test(),
      Program.test(),
      Program.test(),
    ]);

    personalRecords = List<PR>();
    personalRecords.addAll([
      PR.fromExercise(Exercise.squat(), userId: uid, timeOfCompletion: DateTime.now()),
      PR.fromExercise(Exercise.bench(), userId: uid, timeOfCompletion: DateTime.now()),
      PR.fromExercise(Exercise.deadlift(), userId: uid, timeOfCompletion: DateTime.now()),
    ]);
  }
}