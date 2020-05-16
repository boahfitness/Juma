import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/models/lifting/weight.dart';

class User {
  String uid;
  String displayName;
  WeightUnit unitPreference;
  Program currentProgram;
  List<Program> pastPrograms;

  Set<MainLiftDescriptor> trackedLifts;

  User({this.uid});
}