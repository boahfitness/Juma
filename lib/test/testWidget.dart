import 'package:flutter/material.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/pages/app/home/util/CustomRectTween.dart';
import 'package:juma/pages/app/home/util/ui/jumaAppBar.dart';
import 'package:juma/pages/app/routes/baseScaffold.dart';
import 'package:juma/services/googleSheetsService.dart';
import 'package:juma/services/authService.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import 'package:juma/pages/app/appNavigator.dart';
import 'package:juma/pages/app/home/util/contentSections/recommended.dart';
import 'package:juma/pages/app/home/util/contentSections/yourLibrary.dart';

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
          padding: const EdgeInsets.only(top: 20),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              YourLibrarySection(testPrograms: testPrograms),
              RecommendedSection(testPrograms: testPrograms),
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
      appBar: JumaAppBar(),
    );
  }
}

class TestTwo extends StatelessWidget {
  final Program program;
  TestTwo({@required this.program});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            Hero(
              tag: program.id,
              child: Container(
                height: 350,
                width: 250,
                child: ClipRRect(
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
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0, top: 10),
              child: Hero(
                createRectTween: (begin, end) {
                  return CustomRectTween(a: begin, b: end, curveTransform: (t) => Cubic(.72,0,.39,.08).transform(t));
                },
                tag: "title_${program.id}",
                child: Text(
                  program.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 0, top: 5),
              child: Hero(
                createRectTween: (begin, end) {
                  return CustomRectTween(a: begin, b: end, curveTransform: (t) => Cubic(.72,0,.39,.08).transform(t));
                },
                tag: "author_${program.id}",
                child: Text(
                  "${program.author.displayName}"
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}

