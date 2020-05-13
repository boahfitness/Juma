import 'package:juma/models/lifting/exercise.dart';

class PersonalRecords {
  String prid;
  String uid;
  MainLiftType mainLiftType;

  // holding a list of exercises for each rep count
  Map<int, List<PersonalRecord>> data;
}

class PersonalRecord extends Exercise {
  String programId;
  int weekIndex;
  int dayIndex;
}