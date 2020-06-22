import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/models/users/user.dart';

class ProgramTemplate extends Program {
  Map<String, dynamic> toMap([bool x=false]) {
    return super.toMap();
  }
}

class ProgramHistory extends Program {
  bool get completed => null;
  String templateId;
  String uid;

  Map<String, dynamic> toMap([bool x=false]) {
    return super.toMap(true);
  }
}

abstract class Program {
  String id;
  String title;
  UserIdentifier author;
  String description;
  String pathToMedia;
  ColorTheme theme;

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
  List<Week> weeks = List();

  bool get isComplete {
    for (Week week in weeks) {
      if (!week.isComplete) return false;
    }
    return true;
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return {
      'split': split.toMap(),
      'weeks': weeks.map<Map<String, dynamic>>((w) => w.toMap(includeHistory)).toList(),
    };
  }
}

class Week {
  Map<Weekday, Day> days = {
    Weekday.sunday: null,
    Weekday.monday: null,
    Weekday.tuesday: null,
    Weekday.wednesday: null,
    Weekday.thursday: null,
    Weekday.friday: null,
    Weekday.saturday: null
  };

  Day get sunday => days[Weekday.sunday];
  set sunday(Day day) => days.update(Weekday.sunday, (value) => day);

  Day get monday => days[Weekday.monday];
  set monday(Day day) => days.update(Weekday.monday, (value) => day);

  Day get tuesday => days[Weekday.tuesday];
  set tuesday(Day day) => days.update(Weekday.tuesday, (value) => day);

  Day get wednesday => days[Weekday.wednesday];
  set wednesday(Day day) => days.update(Weekday.wednesday, (value) => day);

  Day get thursday => days[Weekday.thursday];
  set thursday(Day day) => days.update(Weekday.thursday, (value) => day);

  Day get friday => days[Weekday.friday];
  set friday(Day day) => days.update(Weekday.friday, (value) => day);

  Day get saturday => days[Weekday.saturday];
  set saturday(Day day) => days.update(Weekday.saturday, (value) => day);

  bool get isComplete {
    for (Day d in days.values) {
      if (d != null && !d.isComplete) return false;
    }
    return true;
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return days.map<String, dynamic>((weekday, day) {
      return MapEntry(weekday.index.toString(), day.toMap(includeHistory));
    });
  }

}

enum Weekday {
  sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

class Day {
  String label;
  List<Exercise> exercises;

  static Day get restDay => RestDay();

  bool get isComplete {
    for (Exercise x in exercises) {
      if (x.status == HistoryStatus.incomplete) return false;
    }
    return true;
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    return {
      'label': label,
      'exercises': exercises.map((e) => e.toMap(includeHistory)).toList(),
    };
  }
}

class RestDay extends Day {
  String get label => 'rest';
  List<Exercise> get exercises => List(0);

  set exercises(List<Exercise> val) => null;
}

