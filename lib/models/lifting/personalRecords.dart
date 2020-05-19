import 'dart:collection';
import 'package:juma/models/lifting/exercise.dart';

class PersonalRecords {
  String id;
  String uid;
  MainLiftDescriptor _liftDescriptor;
  MainLiftDescriptor get liftDescriptor => _liftDescriptor;
  // holding a list of exercises for each rep count
  Map<int, List<PersonalRecord>> _data;
  Map<int, List<PersonalRecord>> get data => _data;

  PersonalRecords(MainLiftDescriptor liftDescriptor) {
    _liftDescriptor = liftDescriptor;
    _data = SplayTreeMap();
  }

  bool addPersonalRecord(PersonalRecord pr) {
    // the lift must match the lift descriptor of the PR data to be added to the data.
    // the lift must also be greater weight than the most recent pr (last)
    MainLiftDescriptor prDescriptor = pr.lift.descriptor;
    if (prDescriptor == _liftDescriptor) {
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

}

class PersonalRecord {
  String programId;
  int weekIndex;
  int dayIndex;
  MainLift lift;

  PersonalRecord(this.programId, this.weekIndex, this.dayIndex, this.lift);
}