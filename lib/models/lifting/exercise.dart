import 'package:flutter/material.dart';
import 'package:juma/models/lifting/weight.dart';
import 'package:path/path.dart' as path;

class Exercise {
  String name;
  int sets;
  int reps;
  Weight weight = Weight();
  Duration rest;
  String coachNotes;
  String athleteNotes;
  DateTime completed;
  //String pathToVideo;

  double get workload {
    return weight.pounds * reps;
  }

  Exercise({this.name, this.sets=0, this.reps=0,
    this.weight, this.rest,
    this.athleteNotes, this.coachNotes, this.completed});
}

class DurationExercise extends Exercise {
  Duration duration;

  double get workload => null;
}

abstract class MainLift extends Exercise {
  double percentage;
  double rpe;
  bool isPR;
  MainLiftDescriptor get descriptor;

  MainLift();

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
    return weight.pounds * (reps + (10.0 - rpe));
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

  Squat({
    @required
    SquatVariation variation,
    @required
    SquatEquipment equipment,
    @required
    KneeEquipment kneeEquipment
  }) {
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
    if (_kneeEquipment == KneeEquipment.wraps) path.join(output, _kneeEquipment.toString().split('.').last);
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
            equipment: equip,
            variation: variation,
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
    _descriptor.value = calculateDescriptorValue();
    _descriptor.path = calculateDescriptorPath();
  }

  MainLiftDescriptor _descriptor;
  @override
  MainLiftDescriptor get descriptor => _descriptor;

  @override
  String get name => 'Bench';

  Bench({
    @required
    BenchEquipment equipment
  }) {
    _equipment = equipment;
    _descriptor = MainLiftDescriptor(value: calculateDescriptorValue(), path: calculateDescriptorPath());
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
    _equipment = equipment;
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

  Deadlift({
    @required
    DeadliftVariation variation,
    @required
    DeadliftEquipment equipment
  }) {
    _variation = variation;
    _equipment = equipment;
    _descriptor = MainLiftDescriptor(value: calculateDescriptorValue(), path: calculateDescriptorPath());
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