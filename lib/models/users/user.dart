import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/models/lifting/weight.dart';

class User {
  String uid;
  String displayName;
  WeightUnit unitPreference;
  Program currentProgram;
  List<Program> programHistory = List();
  List<String> programCatalog = List();

  Set<TrackedLift> trackedLifts = Set();

  User({this.uid});

  bool addNewPR(PersonalRecord newPR) {
    if (newPR == null) return false;
    
    TrackedLift newTL = TrackedLift(newPR.lift.descriptor);
    TrackedLift tl = trackedLifts.lookup(newTL);
    
    if (tl == null) {
      trackedLifts.add(newTL);
      return newTL.addPersonalRecord(newPR);
    }
    else {
      return tl.addPersonalRecord(newPR);
    }
  }
}