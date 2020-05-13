import 'package:juma/models/lifting/program.dart';

class User {
  String uid;
  String displayName;
  Program currentProgram;
  List<Program> pastPrograms;

  User({this.uid});
}