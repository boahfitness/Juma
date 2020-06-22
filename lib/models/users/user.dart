import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/models/lifting/weight.dart';

class User {
  String get uid => identifier.uid;
  set uid(String val) {
    identifier.uid = val;
  }
  String get displayName => identifier.displayName;
  set displayName(String val) {
    identifier.displayName = val;
  }
  UserIdentifier identifier = UserIdentifier();

  WeightUnit unitPreference;
  Program currentProgram;
  List<Program> programHistory = List();
  List<String> programCatalog = List();

  Set<TrackedLift> trackedLifts = Set();

  Gender gender;
  Weight bodyweight = Weight();

  User({String uid, String displayName, this.unitPreference=WeightUnit.pounds, this.gender=Gender.unspecified}) {
    this.uid = uid; this.displayName = displayName;
  }

  bool addNewPR(PersonalRecord newPR) {
    if (newPR == null) return false;
    
    TrackedLift newTL = TrackedLift(newPR.lift.descriptor, uid: uid);
    TrackedLift tl = trackedLifts.lookup(newTL);
    
    if (tl == null) {
      trackedLifts.add(newTL);
      return newTL.addPersonalRecord(newPR);
    }
    else {
      return tl.addPersonalRecord(newPR);
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'unitPreference': unitPreference.index,
      'gender': gender.index,
      'bodyweight': bodyweight.toMap()
    };
  }
}

enum Gender {
  male,
  female,
  unspecified
}

class UserIdentifier {
  String uid;
  String displayName;

  UserIdentifier({this.uid, this.displayName});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName
    };
  }
}