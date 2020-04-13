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

  // user instance variables
  String userId;
  DateTime completed;
  int currentWeekNum = 0;

  Program(this.title, {this.weeks, this.programId, this.authorId, 
    this.authorName, this.description, this.pathToPicture, this.theme});

  Week get currentWeek {
    return weeks.elementAt(currentWeekNum);
  }

  Day get currentDay {
    return this.currentWeek.currentDay;
  }

  Program.test() {
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


class Week {
  Day day1, day2, day3, day4, day5, day6, day7;
  int currentDayNum = 1;

  Week({this.day1, this.day2, this.day3, 
    this.day4, this.day5, this.day6, this.day7});

  Day get currentDay {
    switch (currentDayNum) {
      case 1:  return this.day1; break;
      case 2: return this.day2; break;
      case 3: return this.day3; break;
      case 4: return this.day4; break;
      case 5: return this.day5; break;
      case 6: return this.day6; break;
      case 7: return this.day7; break;
      default: return null;
    }
  }
}

class Day {
  DayType type;
  List<Exercise> exercises;
  DateTime completed;

  Day({this.exercises, this.type=DayType.generic});

  Exercise get firstExercise {
    if (exercises != null && exercises.isNotEmpty)
      return exercises[0];
    else return null;
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
  String athleteNotes;
  String pathToVideo;

  Exercise(this.name, {this.type=ExerciseType.generic, this.sets=0, this.reps=0, 
    this.rpe=RPE.seven, this.weight, this.duration, this.rest,
    this.percentage, this.coachNotes});

  Exercise.squat() {
    name = "Squat";
    type = ExerciseType.mainLiftWithRPE;
    sets = 5; reps = 5;
    weight = Weight(pounds: 545);
  }

  Exercise.bench() {
    name = "Bench";
    type = ExerciseType.mainLiftWithRPE;
    sets = 5; reps = 5;
    weight = Weight(pounds: 315);
  }

  Exercise.deadlift() {
    name = "Deadlift";
    type = ExerciseType.mainLiftWithRPE;
    sets = 5; reps = 5;
    weight = Weight(pounds: 600);
  }
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
  PR(String name, this.timeOfCompletion, int reps, Weight weight) : super(name, reps: reps, weight: weight);
  PR.fromExercise(Exercise x, {this.userId, this.timeOfCompletion, this.previousPR}) : super(x.name) {
    this.reps = x.reps;
    this.weight = x.weight;
  }
}

class OneRepMax extends PR {
  OneRepMax(String name, DateTime timeOfCompletion, int reps, Weight weight) : super(name, timeOfCompletion, reps, weight);
}