import 'package:flutter/material.dart';
import 'package:juma/models.bak/user.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/models.bak/program.dart';
import 'package:juma/widgets/programCard.dart';

AuthService auth = AuthService();

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  @override
  Widget build(BuildContext context) {
    User testUser = User.test();
    Program testProgram = testUser.currentProgram;
    ColorTheme theme = testProgram.theme;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[

            ProgramCard(
              testProgram,
              showBorder: false,
              showAuthor: false,
              showTitle: false,
            ),
            
            //interactive content
            Scaffold(
              backgroundColor: Colors.transparent,
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: SizedBox(height: 5,),
                    ),
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person),
                          Text("Sign Out")
                        ],
                      ),
                      onTap: () {auth.signOut();},
                    ),
                  ],
                ),
              ),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                title: SizedBox(
                  width: 50,
                  height: 35,
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        "JUMA", 
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  )
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 6,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("NEXT WORKOUT", style: wkText(),),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("${testProgram.currentDay.firstExercise.name.toUpperCase()} 5 X 5", style: wkText(),),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text("RPE 7", style: wkText(),),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {},
                backgroundColor: theme.solid,
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: JumaColors.boahDarkGrey,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey[600],
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
                  BottomNavigationBarItem(icon: Icon(Icons.style), title: Text("Programs")),
                  BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile"))
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

TextStyle wkText() {
  return TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 36
  );
}