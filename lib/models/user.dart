import 'package:juma/models/program.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  List<PR> personalRecords;

  UserProgram currentProgram;

  List<UserProgram> pastPrograms;

  User({this.uid});
}