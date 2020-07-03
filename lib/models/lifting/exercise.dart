import 'package:juma/models/lifting/weight.dart';
import 'package:path/path.dart' as path;

class Exercise with ExerciseHistoryMixin {
  String name;
  int sets;
  int reps;
  Weight weight = Weight();
  String coachNotes;
  String athleteNotes;
  //String pathToVideo;

  double get workload {
    return weight.pounds * reps;
  }

  Exercise({this.name, this.sets=0, this.reps=0,
    this.weight, this.coachNotes, this.athleteNotes}) {
      weight??=Weight();
      this.status = HistoryStatus.incomplete;
    }

  Exercise.fromMap(Map<String, dynamic> data, [bool includeHistory = false]) {
    this.name = data['name'] is String ? data['name'] : null;
    if (data['sets'] is num) {
      num s = data['sets'];
      this.sets = s.toInt();
    }
    else this.sets = 0;
    if (data['reps'] is num) {
      num r = data['reps'];
      this.reps = r.toInt();
    }
    else this.reps = 0;
    this.weight = data['weight'] is Map<String, dynamic> ? Weight.fromMap(data['weight']) : Weight();
    this.coachNotes = data['coachNotes'] is String ? data['coachNotes'] : null;

    if (includeHistory && data['historyStatus'] is int) {
      int statusIndex = data['historyStatus'];
      if (statusIndex >= 0 && statusIndex < HistoryStatus.values.length) {
        this.status = HistoryStatus.values[statusIndex];
      }
    }
  }

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    var m =  {
      'name': name,
      'sets': sets,
      'reps': reps,
      'weight': weight != null ? weight.toMap() : null,
      'coachNotes': coachNotes,
    };
    if (includeHistory) m.addEntries([MapEntry(
      'historyStatus', status != null ? status.index : null
    )]);
    return m;
  }
}

class ExerciseDuration {
  int hours, minutes, seconds;
  ExerciseDuration({this.hours=0, this.minutes=0, this.seconds=0});

  Map<String, dynamic> toMap() {
    return {
      'hours': hours, 'minutes': minutes, 'seconds': seconds
    };
  }
}

class DurationExercise extends Exercise {
  ExerciseDuration duration;
  int get reps => null;
  set reps(val) => null;

  Map<String, dynamic> toMap([bool includeHistory=false]) {
    var m =  {
      'name': name,
      'sets': sets,
      'duration': duration != null ? duration.toMap() : null,
      'weight': weight != null ? weight.toMap() : null,
      'coachNotes': coachNotes,
    };
    if (includeHistory) m.addEntries([MapEntry(
      'historyStatus', status != null ? status.index.toString() : null
    )]);
    return m;
  }
}

class ExerciseHistoryMixin {
  HistoryStatus status = HistoryStatus.incomplete;
}

enum HistoryStatus {
  complete,
  incomplete,
  skipped
}







class WorkloadPrescriber {
  double _value;
  double get value {
    switch(type) {
      case WorkloadPrescriberType.percent: return _value * 100; // value: 0.32 => 32%
      case WorkloadPrescriberType.rpe: return roundToHalf(_value * 10); // value: 0.32 => RPE 3
      default: return 0.0;
    }
  }
  set value(double val) {
    _value = val.clamp(0.0, 1.0);
  }

  set rpe(double val) {
    type = WorkloadPrescriberType.rpe;
    val = roundToHalf(val);
    value = val / 10;
  }

  double get rpe {
    type = WorkloadPrescriberType.rpe;
    return value;
  }

  set percentage(double val) {
    type = WorkloadPrescriberType.percent;
    value = val / 100;
  }

  double get percentage {
    type = WorkloadPrescriberType.percent;
    return value;
  }

  WorkloadPrescriberType type;

  WorkloadPrescriber(this.type, {double value}) {
    value ??= 0.0;
    this.value = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type.index,
      'value': _value
    };
  }
}
enum WorkloadPrescriberType {
  rpe,
  percent
}







abstract class MainLift extends Exercise {
  WorkloadPrescriber prescribedWorkload;
  bool isPR;
  MainLiftDescriptor get descriptor;
  MainLiftType get type;

  MainLift({int sets, int reps, Weight weight, String coachNotes, String athleteNotes, this.prescribedWorkload})
    : super(sets: sets, reps: reps, weight: weight, coachNotes: coachNotes, athleteNotes: athleteNotes);

  static MainLift fromDescriptor(MainLiftDescriptor d) {
    MainLiftType type = d.getType();
    switch (type) {
      case MainLiftType.squat: return Squat.fromDescriptor(d);
      case MainLiftType.bench: return Bench.fromDescriptor(d);
      case MainLiftType.deadlift: return Deadlift.fromDescriptor(d);
      default: return null;
    }
  }

  double get rpeWorkload {
    //return weight.pounds * (reps + (10.0 - rpe));
    return null;
  }

  String calculateDescriptorValue();
  String calculateDescriptorPath();

  @override
  bool operator ==(Object other) {
    if (other is MainLift) {
      return other.descriptor == descriptor;
    }
    return false;
  }

  @override
  int get hashCode => descriptor.hashCode;

  @override
  Map<String, dynamic> toMap([bool includeHistory=false]) {
    var m = super.toMap(includeHistory);
    
    m.addEntries([
      MapEntry('prescribedWorkload', prescribedWorkload != null ?  prescribedWorkload.toMap() : null),
      MapEntry('descriptor', descriptor != null ? descriptor.toString() : null)
    ]);

    return m;
  }

}

class MainLiftDescriptor {
  String value;
  String path;

  MainLiftDescriptor.fromLift(MainLift lift) {
    value = lift.calculateDescriptorValue();
    path = lift.calculateDescriptorPath();
  }

  MainLiftDescriptor({this.path, this.value});

  MainLiftType getType() {
    if (value == null || value.isEmpty) {
      return null;
    }
    int typeIndicator = int.parse(value.split('-').first);
    return MainLiftType.values[typeIndicator];
  }


  bool operator ==(dynamic other) {
    if (other.runtimeType == MainLiftDescriptor) {
      return value == other.value;
    }
    return false;
  }
  
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return value;
  }

}

enum MainLiftType {
  squat,
  bench,
  deadlift
}







class Squat extends MainLift {
  KneeEquipment _kneeEquipment;
  KneeEquipment get kneeEquipment => _kneeEquipment;
  set kneeEquipment(KneeEquipment val) {
    _kneeEquipment = val;
    _descriptor.value = calculateDescriptorValue();
    _descriptor.path = calculateDescriptorPath();
  }

  SquatVariation _variation;
  SquatVariation get variation => _variation;
  set variation(SquatVariation val) {
    _variation = val;
    _descriptor.value = calculateDescriptorValue();
    _descriptor.path = calculateDescriptorPath();
  }

  SquatEquipment _equipment;
  SquatEquipment get equipment => _equipment;
  set equipment(SquatEquipment val) {
    _equipment = val;
    _descriptor.value = calculateDescriptorValue();
    _descriptor.path = calculateDescriptorPath();
  }

  MainLiftDescriptor _descriptor;
  @override
  MainLiftDescriptor get descriptor => _descriptor;

  @override
  String get name => 'Squat';

  @override 
  MainLiftType get type => MainLiftType.squat;

  Squat({
    int reps=1, int sets=1, Weight weight, String coachNotes, String athleteNotes,
    WorkloadPrescriber prescribedWorkload,
    SquatVariation variation = SquatVariation.lowBar,
    SquatEquipment equipment = SquatEquipment.raw,
    KneeEquipment kneeEquipment = KneeEquipment.none,
  }) : super(reps: reps, sets: sets, weight: weight, coachNotes: coachNotes, athleteNotes: athleteNotes, prescribedWorkload: prescribedWorkload) {
    _variation = variation;
    _equipment = equipment;
    _kneeEquipment = kneeEquipment;
    _descriptor = MainLiftDescriptor(path: calculateDescriptorPath(), value: calculateDescriptorValue());
  }

  Squat.fromDescriptor(MainLiftDescriptor d) {
    if (d == null || d.value == null || d.value.isEmpty) {
      throw Exception('descriptor cannot be null and value cannot be empty');
    }
    List<int> values = d.value.split('-').map((val) => int.parse(val)).toList();
    if (values.length != 4) throw Exception('Invalid main lift descriptor');
    _variation = SquatVariation.values[values[1]];
    _equipment = SquatEquipment.values[values[2]];
    _kneeEquipment = KneeEquipment.values[values[3]];
    _descriptor = MainLiftDescriptor(value: calculateDescriptorValue(), path: calculateDescriptorPath());
  }

  @override 
  String calculateDescriptorValue() {
    String output = "";
    output += MainLiftType.squat.index.toString() + '-'
      + _variation.index.toString() + '-'
      + _equipment.index.toString() + '-'
      + _kneeEquipment.index.toString();
    return output;
  }

  @override
  String calculateDescriptorPath() {
    String output = path.join(
      MainLiftType.squat.toString().split('.').last,
      _variation.toString().split('.').last,
      _equipment.toString().split('.').last,
    );
    if (_kneeEquipment == KneeEquipment.wraps) {
      output = path.join(output, _kneeEquipment.toString().split('.').last);
    }
    return output
      .toUpperCase()
      .replaceAll('/', '//');
  }

  static List<Squat> getAllPossibleVariations() {
    var variations = SquatVariation.values;
    var equipment = SquatEquipment.values;
    var kneeEquipment = KneeEquipment.values;

    Set<Squat> output = Set();

    variations.forEach((variation) {
      equipment.forEach((equip) {
        kneeEquipment.forEach((kneeEquip) {
          output.add(Squat(
            variation: variation,
            equipment: equip,
            kneeEquipment: kneeEquip
          ));
        });
      });
    });

    return output.toList();
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
  BenchEquipment _equipment;
  BenchEquipment get equipment => _equipment;
  set equipment(BenchEquipment val) {
    _equipment = val;
    _descriptor.value = calculateDescriptorValue();
    _descriptor.path = calculateDescriptorPath();
  }

  MainLiftDescriptor _descriptor;
  @override
  MainLiftDescriptor get descriptor => _descriptor;

  @override
  String get name => 'Bench';

  @override 
  MainLiftType get type => MainLiftType.bench;

  Bench({
    int reps=1, int sets=1, Weight weight, String coachNotes, String athleteNotes,
    WorkloadPrescriber prescribedWorkload,
    BenchEquipment equipment = BenchEquipment.raw,
  }) : super(reps: reps, sets: sets, weight: weight, coachNotes: coachNotes, athleteNotes: athleteNotes, prescribedWorkload: prescribedWorkload) {
    _equipment = equipment;
    _descriptor = MainLiftDescriptor(value: calculateDescriptorValue(), path: calculateDescriptorPath());
    this.weight = Weight();
    this.reps = reps;
  }

  Bench.fromDescriptor(MainLiftDescriptor d) {
    if (d == null || d.value == null || d.value.isEmpty) {
      throw Exception('descriptor cannot be null and value cannot be empty');
    }
    List<int> values = d.value.split('-').map((val) => int.parse(val)).toList();
    if (values.length != 2) throw Exception('Invalid main lift descriptor');
    _equipment = BenchEquipment.values[values[1]];
    _descriptor = MainLiftDescriptor(value: calculateDescriptorValue(), path: calculateDescriptorPath());
  }

  @override 
  String calculateDescriptorValue() {
    String output = "";
    output += MainLiftType.bench.index.toString() + '-'
      + _equipment.index.toString();
    return output;
  }

  @override 
  String calculateDescriptorPath() {
    String output = path.join(
      MainLiftType.bench.toString().split('.').last,
      _equipment.toString().split('.').last
    );
    return output
      .toUpperCase()
      .replaceAll('/', '//');
  }

  static List<Bench> getAllPossibleVariations() {
    var equipment = BenchEquipment.values;
    Set<Bench> output = Set();

    equipment.forEach((element) {
      output.add(Bench(equipment: element));
    });
    
    return output.toList();
  }

}
enum BenchEquipment {
  raw,
  slingshot,
  shirt
}










class Deadlift extends MainLift {
  DeadliftEquipment _equipment;
  DeadliftEquipment get equipment => _equipment;
  set equipment(DeadliftEquipment val) {
    _equipment = val;
    _descriptor.value = calculateDescriptorValue();
    _descriptor.path = calculateDescriptorPath();
  }

  DeadliftVariation _variation;
  DeadliftVariation get variation => _variation;
  set variation(DeadliftVariation val) {
    _variation = val;
    _descriptor.value = calculateDescriptorValue();
    _descriptor.path = calculateDescriptorPath();
  }

  MainLiftDescriptor _descriptor;
  @override
  MainLiftDescriptor get descriptor => _descriptor;

  @override
  String get name => 'Deadlift';

  @override
  MainLiftType get type => MainLiftType.deadlift;

  Deadlift({
    int reps=1, int sets=1, Weight weight, String coachNotes, String athleteNotes,
    WorkloadPrescriber prescribedWorkload,
    DeadliftVariation variation = DeadliftVariation.conv,
    DeadliftEquipment equipment = DeadliftEquipment.raw,
  }) : super(reps: reps, sets: sets, weight: weight, coachNotes: coachNotes, athleteNotes: athleteNotes, prescribedWorkload: prescribedWorkload) {
    _variation = variation;
    _equipment = equipment;
    _descriptor = MainLiftDescriptor(value: calculateDescriptorValue(), path: calculateDescriptorPath());
    this.weight = Weight();
    this.reps = reps;
  }

  Deadlift.fromDescriptor(MainLiftDescriptor d) {
    if (d == null || d.value == null || d.value.isEmpty) {
      throw Exception('descriptor cannot be null and value cannot be empty');
    }
    List<int> values = d.value.split('-').map((val) => int.parse(val)).toList();
    if (values.length != 3) throw Exception('Invalid main lift descriptor');
    _variation = DeadliftVariation.values[values[1]];
    _equipment = DeadliftEquipment.values[values[2]];
    _descriptor = MainLiftDescriptor(value: calculateDescriptorValue(), path: calculateDescriptorPath());
  }

  @override 
  String calculateDescriptorValue() {
    String output = "";
    output += MainLiftType.deadlift.index.toString() + '-'
      + _variation.index.toString() + '-'
      + _equipment.index.toString();
    return output;
  }

  @override 
  String calculateDescriptorPath() {
    String output = path.join(
      MainLiftType.deadlift.toString().split('.').last,
      _variation.toString().split('.').last,
      _equipment.toString().split('.').last
    );
    return output 
      .toUpperCase()
      .replaceAll('/', '//');
  }

  static List<Deadlift> getAllPossibleVariations() {
    var variations = DeadliftVariation.values;
    var equipment = DeadliftEquipment.values;
    Set<Deadlift> output = Set();

    variations.forEach((variation) {
      equipment.forEach((equip) {
        output.add(
          Deadlift(
            equipment: equip,
            variation: variation
          )
        );
      });
    });

    return output.toList();
  }

}
enum DeadliftEquipment {
  raw,
  suit,
  breifs,
}

enum DeadliftVariation {
  sumo,
  conv
}