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
  ProgramHistory currentProgram;
  //List<ProgramHistory> programHistory = List();
  List<String> programCatalog = List();

  Set<TrackedLift> trackedLifts = Set();

  Gender gender;
  Weight bodyweight;

  User({String uid, String displayName, this.unitPreference=WeightUnit.pounds, this.gender=Gender.unspecified}) {
    this.identifier = UserIdentifier();
    this.uid = uid; this.displayName = displayName;
    this.bodyweight ??= Weight();
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

  User.fromMap(Map<String, dynamic> data) {
    this.identifier = UserIdentifier();
    this.uid = data['uid'] is String ? data['uid'] : null;
    this.displayName = data['displayName'] is String ? data['displayName'] : null;
    
    int unitIndex = data['unitPreference'] is int ? data['unitPreference'] : null;
    this.unitPreference = unitIndex != null && unitIndex >= 0 && unitIndex < WeightUnit.values.length ? WeightUnit.values[unitIndex] : WeightUnit.pounds;

    int genderIndex = data['gender'] is int ? data['gender'] : null;
    this.gender = genderIndex != null && genderIndex >= 0 && genderIndex < Gender.values.length ? Gender.values[genderIndex] : Gender.unspecified;

    this.bodyweight = data['bodyweight'] is Map<String, dynamic> ? Weight.fromMap(data['bodyweight']) : Weight();
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

  UserIdentifier.fromMap(Map<String, dynamic> data) {
    this.uid = data['uid'];
    this.displayName = data['displayName'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName
    };
  }
}