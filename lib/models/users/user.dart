import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/models/lifting/personalRecords.dart';

class User {
  String uid;
  String displayName;
  Program currentProgram;
  List<Program> pastPrograms;

  Map<MainLift, PersonalRecords> personalRecords;

  User({this.uid});
}