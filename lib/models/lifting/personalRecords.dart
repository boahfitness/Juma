import 'dart:collection';
import 'package:juma/models/lifting/exercise.dart';

class PersonalRecords {
  String uid;
  Set<TrackedLift> _data = Set();
  Set<TrackedLift> get data => _data;

  PersonalRecords(this.uid);

  bool addNewPR(PersonalRecord newPR) {
    if (newPR == null) return false;

    TrackedLift newTL = TrackedLift(newPR.lift.descriptor, uid: uid);
    TrackedLift tl = _data.lookup(newTL);

    if (tl == null) {
      data.add(newTL);
      return newTL.addPersonalRecord(newPR);
    }
    else {
      return tl.addPersonalRecord(newPR);
    }
  }
}

class TrackedLift {
  String id;
  String uid;
  MainLiftDescriptor _liftDescriptor;
  MainLiftDescriptor get liftDescriptor => _liftDescriptor;
  // holding a list of exercises for each rep count
  Map<int, List<PersonalRecord>> _data;
  Map<int, List<PersonalRecord>> get data => _data;

  TrackedLift(MainLiftDescriptor liftDescriptor, {this.uid, this.id}) {
    _liftDescriptor = MainLiftDescriptor(path: liftDescriptor.path, value: liftDescriptor.value);
    _data = SplayTreeMap();
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == TrackedLift) {
      TrackedLift otherLift = other;
      if (otherLift.liftDescriptor == this._liftDescriptor) {
        return true;
      }
    }
    return false;
  }

  Map<String, List<Map>> get dataMap {
    return _data.map<String, List<Map<String, dynamic>>>((reps, prList) {
      List<Map<String, dynamic>> prMaps = prList.map((pr) => pr.toMap()).toList();
      return MapEntry(reps.toString(), prMaps);
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'liftDescriptor': _liftDescriptor.value,
      'data': dataMap
    };
  }

  @override
  int get hashCode => _liftDescriptor.hashCode;

  bool addPersonalRecord(PersonalRecord pr) {
    // the lift must match the lift descriptor of the PR data to be added to the data.
    // the lift must also be greater weight than the most recent pr (last)
    MainLiftDescriptor prDescriptor = pr.lift.descriptor;
    if (prDescriptor == _liftDescriptor 
          && pr.lift.weight != null
          && pr.lift.reps != null) { // pr must have a weight to be added
      int prReps = pr.lift.reps;

      _data.putIfAbsent(prReps, () => List());
      
      List<PersonalRecord> prList = _data[prReps];

      if (prList.isEmpty) {
        prList.add(pr);
        return true;
      }
      //check if pr weight is greater than weight of most recent pr
      else if (pr.lift.weight.pounds > prList.last.lift.weight.pounds) {
        prList.add(pr);
        return true;
      }
    }
    return false;
  }

  PersonalRecord getRecentPrForReps(int reps) {
    if (_data.containsKey(reps) && _data[reps].isNotEmpty) {
      return _data[reps].last;
    }
    else {
      return null;
    }
  }

  List<PersonalRecord> getPrForEachRep() {
    List<PersonalRecord> output = List();
    for (int reps in _data.keys) {
      var pr = getRecentPrForReps(reps);
      if (pr != null) output.add(pr);
    }
    return output;
  }

}

class PersonalRecord {
  String programId;
  int weekIndex;
  int dayIndex;
  MainLift lift;

  PersonalRecord(this.programId, this.weekIndex, this.dayIndex, this.lift);

  Map<String, dynamic> toMap() {
    return {
      'programId': programId,
      'weekIndex': weekIndex,
      'dayIndex': dayIndex,
      'lift': lift.toMap()
    };
  }
}