import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/theme/Colors.dart';

class Program {
  String title;
  String programId;
  String uid;
  List<Week> weeks;
  String authorId;
  String authorName;
  String description;
  String pathToPicture;
  ColorTheme theme;
  DateTime completed;

  Day get currentDay {
    // TODO: implement function to get the current day
    return Day();
  }
}

class Week {
  List<Day> days;
  DateTime completed; 
}

class Day {
  DayType type;
  List<Exercise> exercises;
  DateTime completed;

  Day({this.exercises, this.type=DayType.work, this.completed});
}

enum DayType {
  work,
  rest
}