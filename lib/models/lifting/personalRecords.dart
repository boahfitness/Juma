import 'package:juma/models/lifting/exercise.dart';

class PersonalRecords<T extends MainLift> {
  String prid;
  String uid;
  T liftDescriptor;

  // holding a list of exercises for each rep count
  Map<int, List<PersonalRecord<T>>> data;
}

class PersonalRecord<T extends MainLift> {
  String programId;
  int weekIndex;
  int dayIndex;
  T lift;
}