import 'package:flutter/material.dart';
import 'package:juma/services/googleSheetsService.dart';
import 'package:juma/services/authService.dart';

void main() async {
  print('*****RUNNING TEST*****');
  WidgetsFlutterBinding.ensureInitialized();
  var authService = AuthService();
  var googleSheetService = GoogleSheetsService();

  var user = await authService.currentUser;

  if (user != null) authService.signOut();

  await authService.signInWithGoogle();
  user = await authService.currentUser;
  await googleSheetService.createSpreadsheet(user.email);

  // await authService.signInWithEmailAndPassword('kevboah@gmail.com', 'Compeng!997');
  // await googleSheetService.createSpreadsheet('kevboah@gmail.com');
}

class Test extends StatefulWidget {
  @override 
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('DSLFA;'),
    );
  }
}