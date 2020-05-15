import 'package:juma/models/lifting/exercise.dart';

class PersonalRecords {
  String prid;
  String uid;
  MainLiftDescriptor _liftDescriptor;
  MainLiftDescriptor get liftDescriptor {
    return _liftDescriptor;
  }

  // holding a list of exercises for each rep count
  Map<int, List<PersonalRecord>> data;

  PersonalRecords(MainLiftDescriptor liftDescriptor) {
    _liftDescriptor = liftDescriptor;
    data = Map();
  }
}

class PersonalRecord {
  String programId;
  int weekIndex;
  int dayIndex;
  MainLift lift;
}