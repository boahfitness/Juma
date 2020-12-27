import 'dart:collection';

import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/models/users/user.dart';

// TODO program and exercise copy methods that do not pass by reference

class ProgramDescriptor {
  String id;
  String title;
  UserIdentifier author;
  String description;
  String pathToMedia;
  ColorTheme theme;

  ProgramDescriptor({this.id, this.title, this.author, this.description, this.pathToMedia, this.theme});

  ProgramDescriptor.fromMap(Map<String, dynamic> data) {
    this.id = data['id'] is String ? data['id'] : null;
    this.title = data['title'] is String ? data['title'] : null;
    this.author = data['author'] is Map ? UserIdentifier.fromMap(data['author']) : null;
    this.description = data['description'] is String ? data['description'] : null;
    this.pathToMedia = data['pathToMedia'] is String ? data['pathToMedia'] : null;

    int themeIndex = data['theme'] is int ? data['theme'] : null;
    if (themeIndex != null && themeIndex >= 0  && themeIndex < ThemeType.values.length)
      this.theme = ColorTheme.getTheme(ThemeType.values[themeIndex]);
    else
      this.theme = null;
  }
}

class ProgramTemplate extends Program {

  ProgramTemplate({String id, String title, UserIdentifier author, String description, String pathToMedia, List<TrainingBlock> trainingBlocks, ColorTheme theme}) 
  : super(id: id, title: title, author: author, description: description, pathToMedia: pathToMedia, trainingBlocks: trainingBlocks, theme: theme);

  static ProgramTemplate fromMap(Map<String, dynamic> data) {
    return Program.fromMap(data);
  }

  Map<String, dynamic> toMap([bool x=false]) {
    return super.toMap();
  }
}

class ProgramHistory extends Program {
  bool get isComplete {
    for (TrainingBlock t in trainingBlocks) if (!t.isComplete) return false;
    return true;
  }
  TrainingBlock get nextTrainingBlock {
    return trainingBlocks != null && trainingBlocks.isNotEmpty ? trainingBlocks.firstWhere((tb) => !tb.isComplete, orElse: () => null) : null;
  }

  Day get nextDay {
    var nextTB = this.nextTrainingBlock;
    if (nextTB == null) return null;
    var nextWeek = nextTB.nextWeek;
    if (nextWeek == null) return null;
    return nextWeek.nextDay;
  }

  String templateId;
  String uid;

  ProgramHistory() 
  : super();

  ProgramHistory.fromTemplate(ProgramTemplate programTemplate, {this.uid}) {
    this.title = programTemplate.title;
    this.author = programTemplate.author;
    this.description = programTemplate.description;
    this.pathToMedia = programTemplate.pathToMedia;
    this.theme = programTemplate.theme;
    this.trainingBlocks = programTemplate.trainingBlocks;
    this.templateId = programTemplate.id;
    // TODO do with no config of exercises
  }

 static ProgramHistory fromMap(Map<String, dynamic> data) {
   ProgramHistory m = Program.fromMap(data, true);
   m.templateId = data['templateId'] is String ? data['templateId'] : null;
   m.uid = data['uid'] is String ? data['uid'] : null;
   return m;
 }

  Map<String, dynamic> toMap([bool x=false]) {
    var m = super.toMap(true);
    m.addEntries([
      MapEntry('templateId', templateId),
      MapEntry('uid', uid)
    ]);
    return m;
  }
}

abstract class Program {
  String id;
  String title;
  UserIdentifier author;
  String description;
  String pathToMedia;
  ColorTheme theme;

  Program({this.id, this.title, this.author, this.description, this.pathToMedia, this.trainingBlocks, this.theme});

  List<TrainingBlock> trainingBlocks = List();

  static Program fromMap(Map<String, dynamic> data, [bool includeHistory = false]) {
    Program p;
    if (includeHistory) p = ProgramHistory();
    else p = ProgramTemplate();
    p.id = data['id'] is String ? data['id'] : null;
    p.title = data['title'] is String ? data['title'] : null;
    p.author = data['author'] is Map ? UserIdentifier.fromMap(data['author']) : null;
    p.description = data['description'] is String ? data['description'] : null;
    p.pathToMedia = data['pathToMedia'] is String ? data['pathToMedia'] : null;

    int themeIndex = data['theme'] is int ? data['theme'] : null;
    if (themeIndex != null && themeIndex >= 0  && themeIndex < ThemeType.values.length)
      p.theme = ColorTheme.getTheme(ThemeType.values[themeIndex]);
    else
      p.theme = null;

    if (data['trainingBlocks'] is List) {
      List tbs = data['trainingBlocks'];
      List<TrainingBlock> trainingBlocks = List();
      tbs.forEach((tb) {
        if (tb is Map<String, dynamic>) {
          trainingBlocks.add(TrainingBlock.fromMap(tb));
        }
      });
      p.trainingBlocks = trainingBlocks;
    }
    else {
      p.trainingBlocks = List();
    }

    return p;
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return {
      'title': title,
      'author': author != null ? author.toMap() : null,
      'description': description,
      'pathToMedia': pathToMedia,
      'theme': theme != null ? theme.type.index : null,
      'trainingBlocks': trainingBlocks != null ? trainingBlocks.map<Map<String, dynamic>>((tb) => tb.toMap(includeHistory)).toList() : null
    };
  }
}

class TrainingBlock {
  Week split;
  Map<int, Week> weeks;

  TrainingBlock({this.split, this.weeks}) {
    weeks??=SplayTreeMap();
  }

  TrainingBlock.fromMap(Map<String, dynamic> data, [bool includeHistory=false]) {
    this.split = data['split'] is Map<String, dynamic> ? Week.fromMap(data['split']) : null;
    this.weeks = SplayTreeMap();
    if (data['weeks'] is Map<String, dynamic>) {
      Map<String, dynamic> weeksData = data['weeks'];
      weeksData.keys.forEach((key) { 
        int weekNum = int.tryParse(key);
        if (weekNum != null && weeksData[key] is Map<String, dynamic>) {
          this.weeks.addEntries([MapEntry(weekNum, Week.fromMap(weeksData[key], includeHistory))]);
        }
      });
    }
  }

  bool get isComplete {
    for (Week week in weeks.values) {
      if (!week.isComplete) return false;
    }
    return true;
  }

  Week get nextWeek {
    return weeks != null && weeks.values.isNotEmpty ? weeks.values.firstWhere((week) => !week.isComplete, orElse: () => null) : null;
  }

  // void addTemplateWeek() {
  //   if (split == null) return;
  //   weeks.add(split);
  // }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return {
      'split': split != null ? split.toMap() : null,
      'weeks': weeks != null ? weeks.map<String, dynamic>((key, value) => MapEntry(key.toString(), value.toMap(includeHistory))) : null,
    };
  }
}

class Week {
  Map<Weekday, Day> days;

  Week({
    Day sunday, Day monday, Day tuesday, Day wednesday, Day thursday, Day friday, Day saturday
  }) {
    this.days = {};
    if (sunday != null) this.sunday = sunday; 
    if (monday != null) this.monday = monday;
    if (tuesday != null) this.tuesday = tuesday; 
    if (wednesday != null) this.wednesday = wednesday; 
    if (thursday != null) this.thursday = thursday; 
    if (friday != null) this.friday = friday; 
    if (saturday != null) this.saturday = saturday;
  }

  Week.fromDays({this.days}) {if (days == null) days = {};}

  Week.fromMap(Map<String, dynamic> data, [bool includeHistory=false]) {
    this.days = {};
    data.keys.forEach((key) {
      int dayNum = int.tryParse(key);
      if (dayNum != null && dayNum >= 0 && dayNum < Weekday.values.length && data[key] is Map<String, dynamic>) {
        this.days.addEntries([MapEntry(Weekday.values[dayNum], Day.fromMap(data[key], includeHistory))]);
      }
    });
  }

  Day get nextDay {
    return days != null && days.values.isNotEmpty ? days.values.firstWhere((day) => !day.isComplete, orElse: () => null) : null;
  }

  Day get sunday => days[Weekday.sunday];
  set sunday(Day day) => days.update(Weekday.sunday, (value) => day, ifAbsent: () => day);

  Day get monday => days[Weekday.monday];
  set monday(Day day) => days.update(Weekday.monday, (value) => day, ifAbsent: () => day);

  Day get tuesday => days[Weekday.tuesday];
  set tuesday(Day day) => days.update(Weekday.tuesday, (value) => day, ifAbsent: () => day);

  Day get wednesday => days[Weekday.wednesday];
  set wednesday(Day day) => days.update(Weekday.wednesday, (value) => day, ifAbsent: () => day);

  Day get thursday => days[Weekday.thursday];
  set thursday(Day day) => days.update(Weekday.thursday, (value) => day, ifAbsent: () => day);

  Day get friday => days[Weekday.friday];
  set friday(Day day) => days.update(Weekday.friday, (value) => day, ifAbsent: () => day);

  Day get saturday => days[Weekday.saturday];
  set saturday(Day day) => days.update(Weekday.saturday, (value) => day, ifAbsent: () => day);

  bool get isComplete {
    for (Day d in days.values) {
      if (d != null && !d.isComplete) return false;
    }
    return true;
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return days != null ? days.map<String, dynamic>((weekday, day) {
      return MapEntry(weekday.index.toString(), day.toMap(includeHistory));
    }) : null;
  }

}

enum Weekday {
  sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

class Day {
  String label;
  SplayTreeMap<int, Exercise> exercises;

  Day({this.label, this.exercises}) {
    exercises ??= SplayTreeMap();
  }

  Day.fromMap(Map<String, dynamic> data, [bool includeHistory = false]) {
    this.label = data['labal'] is String ? data['label'] : null;
    exercises = SplayTreeMap();
    if (data['exercises'] is Map<String, dynamic>) {
      Map<String, dynamic> exerciseData = data['exercises'];
      exerciseData.keys.forEach((key) {
        int exerciseNum = int.tryParse(key);
        if (exerciseNum != null && exerciseData[key] is Map<String, dynamic>) {
          this.exercises.addEntries([MapEntry(exerciseNum, Exercise.fromMap(exerciseData[key], includeHistory))]);
        }
      });
    }
  }

  static Day get restDay => RestDay();

  bool get isComplete {
    for (Exercise x in exercises.values) {
      if (x.status == HistoryStatus.incomplete) return false;
    }
    return true;
  }

  // Exercise get nextExercise {
  //   return exercises.values.firstWhere((ex) => ex.status != HistoryStatus.complete);
  // }

  Exercise get firstExercise {
    return exercises != null && exercises.values.isNotEmpty ? exercises.values.first : null;
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return {
      'label': label != null ? label : null,
      'exercises': exercises != null ? exercises.map((key, value) => MapEntry(key.toString(), value.toMap(includeHistory))) : null,
    };
  }
}

class RestDay extends Day {
  String get label => 'rest';
  SplayTreeMap<int, Exercise> get exercises => null;

  set exercises(SplayTreeMap<int, Exercise> val) => null;
}

