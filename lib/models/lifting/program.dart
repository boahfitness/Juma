import 'dart:collection';

import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/models/users/user.dart';

// TODO program and exercise copy methods that do not pass by reference
// TODO program template better configuration

class ProgramTemplate extends Program {

  ProgramTemplate({String id, String title, UserIdentifier author, String description, String pathToMedia, List<TrainingBlock> trainingBlocks}) 
  : super(id: id, title: title, author: author, description: description, pathToMedia: pathToMedia, trainingBlocks: trainingBlocks);

  Map<String, dynamic> toMap([bool x=false]) {
    return super.toMap();
  }
}

class ProgramHistory extends Program {
  bool get completed => null;
  String templateId;
  String uid;

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

  bool get isComplete {
    for (TrainingBlock t in trainingBlocks) if (!t.isComplete) return false;
    return true;
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return {
      'title': title,
      'author': author != null ? author.toMap() : null,
      'description': description,
      'pathToMedia': pathToMedia,
      'theme': theme != null ? theme.runtimeType : null,
      'trainingBlocks': trainingBlocks.map<Map<String, dynamic>>((tb) => tb.toMap(includeHistory)).toList()
    };
  }
}

class TrainingBlock {
  Week split;
  Map<int, Week> weeks;

  TrainingBlock({this.split, this.weeks}) {
    weeks??=SplayTreeMap();
  }

  bool get isComplete {
    for (Week week in weeks.values) {
      if (!week.isComplete) return false;
    }
    return true;
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
    this.sunday = sunday??=Day.restDay; 
    this.monday = monday??=Day.restDay;
    this.tuesday = tuesday??=Day.restDay; 
    this.wednesday = wednesday??=Day.restDay; 
    this.thursday = thursday??=Day.restDay; 
    this.friday = friday??=Day.restDay; 
    this.saturday = saturday??=Day.restDay;
  }

  Week.fromDays({this.days}) {if (days == null) days = {};}

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

  static Day get restDay => RestDay();

  bool get isComplete {
    for (Exercise x in exercises.values) {
      if (x.status == HistoryStatus.incomplete) return false;
    }
    return true;
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

