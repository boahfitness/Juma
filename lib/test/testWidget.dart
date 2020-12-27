import 'package:flutter/material.dart';
import 'package:juma/services/googleSheetsService.dart';
import 'package:juma/services/authService.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

void main() async {
  print('*****RUNNING TEST*****');
  WidgetsFlutterBinding.ensureInitialized();
  var authService = AuthService();
  var googleSheetService = GoogleSheetsService();

  var user = await authService.currentUser;

  if (user != null) authService.signOut();

  await authService.signInWithGoogle();
  user = await authService.currentUser;
  String newSheetUrl = await googleSheetService.createSpreadsheet(user.email);

  if (newSheetUrl != null) {
    await urlLauncher.launch(newSheetUrl);
  }
  else {
    print('error creating google sheet');
  }
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