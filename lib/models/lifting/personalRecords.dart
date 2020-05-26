import 'dart:collection';
import 'package:juma/models/lifting/exercise.dart';

class TrackedLift {
  String id;
  String uid;
  MainLiftDescriptor _liftDescriptor;
  MainLiftDescriptor get liftDescriptor => _liftDescriptor;
  // holding a list of exercises for each rep count
  Map<int, List<PersonalRecord>> _data;
  Map<int, List<PersonalRecord>> get data => _data;

  TrackedLift(MainLiftDescriptor liftDescriptor) {
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
      output.add(getRecentPrForReps(reps));
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
}