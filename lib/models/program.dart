import 'package:juma/theme/Colors.dart';

class Program {
  String title;
  String programId;
  List<Week> weeks;
  String authorId;
  String authorName;
  String description;
  String pathToPicture; // this will be pulled from firebase
  ColorTheme theme;

  Program(this.title, {this.weeks, this.programId, this.authorId, 
    this.authorName, this.description, this.pathToPicture, this.theme});

  Program.sample() {
    title = "The Powerbuilding Program";
    programId = "0283rb878hrbos";
    authorId = "3k4e9hdbjafds89";
    authorName = "Kevin Yeboah";
    description = "A perfect mix between powerlifting training and bodybuilding. " +
      "This program was designed to get you strong and swole at the same time. " +
      "12 weeks of brutal heavy training and calculated accessory work.";
    pathToPicture = "assets/myPhoto.jpg";
    theme = RedTheme();

    Exercise ex1 = new Exercise(
      "Squats",
      type: ExerciseType.mainLiftWithRPE,
      sets: 5, reps: 5,
      rpe: RPE.eight,
      coachNotes: "5 second pause",
    );

    Exercise ex2 = new Exercise(
      "DB shoulder press",
      type: ExerciseType.accessoryWithWeight,
      sets: 3, reps: 10,
      weight: Weight(pounds: 25),
    );

    Exercise ex3 = new Exercise(
      "Jumping jacks",
      type: ExerciseType.accessoryWithDuration,
      sets: 2, duration: Duration(minutes: 1, seconds: 30),
      rest: Duration(minutes: 1)
    );

    Day day = Day(exercises: [ex1, ex2, ex3]);

    Week week = Week(
      day1: day, day2: Day(type: DayType.rest),
      day3: day, day4: Day(type: DayType.rest),
      day5: day, day6: Day(type: DayType.rest),
      day7: day
    );

    weeks = [week, week, week, week, week];
  }
}

class UserProgram extends Program {
  String userId;
  DateTime completed;

  UserProgram(String title, this.userId) : super(title);

  UserProgram.fromProgram(Program p, this.userId) : super(p.title, 
    weeks: p.weeks, programId: p.programId, authorId: p.authorId,
    authorName: p.authorName, description: p.description, 
    pathToPicture: p.pathToPicture, theme: p.theme);
}

class Week {
  Day day1, day2, day3, day4, day5, day6, day7;
  Week({this.day1, this.day2, this.day3, 
    this.day4, this.day5, this.day6, this.day7});
  
  CompletedWeek toCompletedWeek() {
    return CompletedWeek.fromWeek(this);
  }
}

class CompletedWeek extends Week {
  CompletedWeek.fromWeek(Week w) {
    this.day1 = w.day1;
    this.day2 = w.day2;
    this.day3 = w.day3;
    this.day4 = w.day4;
    this.day5 = w.day5;
    this.day6 = w.day6;
    this.day7 = w.day7;
  }
}

class Day {
  DayType type;
  List<Exercise> exercises;

  Day({this.exercises, this.type=DayType.generic});

  CompletedDay toCompletedDay() {
    return CompletedDay.fromDay(this);
  }
}

class CompletedDay extends Day {
  DateTime completed;

  CompletedDay.fromDay(Day d, {this.completed}) {
    this.type = d.type;
    this.exercises = d.exercises;
  }
}

enum DayType {
  generic,
  rest
}

class Exercise {
  ExerciseType type;
  String name;
  int sets;
  int reps;
  RPE rpe;
  Weight weight = Weight();
  Duration duration;
  Duration rest;
  double percentage;
  String coachNotes;

  Exercise(this.name, {this.type=ExerciseType.generic, this.sets=0, this.reps=0, 
    this.rpe=RPE.seven, this.weight, this.duration, this.rest,
    this.percentage, this.coachNotes});

  CompletedExercise toCompletedExercise() {
    return CompletedExercise.fromExercise(this);
  }
}

class CompletedExercise extends Exercise {
  String pathToVideo; // might change to Path Type
  String athleteNotes;

  CompletedExercise(String name, {this.pathToVideo, this.athleteNotes}) : super(name);

  CompletedExercise.fromExercise(Exercise x, {this.athleteNotes, this.pathToVideo}) : super(x.name, type: x.type,
    sets: x.sets, reps: x.reps, rpe: x.rpe, weight: x.weight,
    duration: x.duration, rest: x.rest, percentage: x.percentage,
    coachNotes: x.coachNotes);
}

enum ExerciseType {
  generic,
  mainLiftWithRPE,
  mainLiftWithWeight,
  mainLiftWithPercentage,
  accessoryWithRPE,
  accessoryWithWeight,
  accessoryWithPercentage,
  accessoryWithDuration,
}

enum MainLifts {
  bench,
  squat,
  deadlift
}

enum RPE {
  five,
  fiveFive,
  six,
  sixFive,
  seven,
  sevenFive,
  eight,
  eightFive,
  nine,
  nineFive,
  ten
}

class Weight {
  double pounds;
  double kilos;

  Weight({this.pounds, this.kilos}) {
    if (pounds == null && kilos == null) {
      pounds = kilos = 0;
    } else {
      kilos ??= poundsToKilos(pounds);
      pounds ??= kilosToPounds(kilos);
    }
  }

  static double poundsToKilos(double pounds) {
    return pounds / 2.205;
  }

  static double kilosToPounds(double kilos) {
    return kilos * 2.205;
  }

  static calculatePoundPlates(double pounds, {double barWeight = 45}) {
    // TODO implete calc pound plates

    // method: subtract barweight and round input to nearest 5
    //keep adding 45 till get over weight then go back
    //keep adding 25s till get over then go back;
    //ans so on.. until hit weight
  }

  static calculateKiloPlates(double kilos, {double barWeight = 20}) {
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

class PR extends Exercise {
  String userId;
  DateTime timeOfCompletion;
  PR previousPR;
  PR(String name, this.timeOfCompletion) : super(name);
}

class OneRepMax extends PR {
  OneRepMax(String name, DateTime timeOfCompletion) : super(name, timeOfCompletion);
}