import 'dart:math';

import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/services/googleSheetsService.dart';
import 'package:juma/services/authService.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import 'package:juma/pages/app/appNavigator.dart';

import 'package:juma/test/data/programsData.dart';

// test main for running test functions
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


// Test widget for testing displays and UIs
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
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: AppNavigator(
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: 15, top: 20),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recommended", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Container(
                height: 430,
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: testPrograms.length,
                  itemBuilder: (context, index) {
                    Program program = testPrograms[index];
                    Random rand = Random();
                    int numWeeks = rand.nextInt(16);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 15),
                          height: 350,
                          width: 250,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: ShaderMask(
                                  blendMode: BlendMode.color,
                                  shaderCallback: (bounds) {
                                    return program.theme.gradient.createShader(bounds);
                                  },
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      return LinearGradient(
                                        colors: [Colors.transparent, Colors.black],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        stops: [0.0, 0.5]
                                      ).createShader(bounds);
                                    },
                                    blendMode: BlendMode.dstATop,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(program.pathToMedia)
                                        ),
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            program.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text(
                            "$numWeeks ${numWeeks == 1 ? 'week' : 'weeks'}"
                          )
                        )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
        ),
        key: GlobalKey<NavigatorState>()
      ).nav,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.person),
          )
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          width: 55,
          height: 30,
          child: Container(
            color: Colors.white,
            child: Center(
              child: Text(
                "JUMA",
                style: TextStyle(color: Colors.black, fontFamily: 'Oswald', fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ),
      ),
    );
  }
}