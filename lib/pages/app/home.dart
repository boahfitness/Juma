import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/theme/Colors.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    if (user == null) Navigator.of(context).pushReplacementNamed('/'); // in case somehow it got here without going through the auth entry check
    return Scaffold(
      backgroundColor: Colors.transparent,

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

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Current Program', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                gradient: GreenTheme().gradient,
                borderRadius: BorderRadius.circular(40)
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, bottom: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Your Library', textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                ],
              ),
            ),
            Container(
              height: 160,
              child: Transform.translate(
                offset: Offset(20, 0.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ProgramDecal(theme: RedTheme(),),
                    ProgramDecal(theme: GoldTheme(),),
                    ProgramDecal(theme: PurpleTheme(),),
                    ProgramDecal(theme: GreenTheme(),),
                    ProgramDecal(theme: BlackTheme(),),
                    ProgramDecal(theme: GoldTheme(),),
                    ProgramDecal(theme: PurpleTheme(),)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      drawer: Drawer(),
    );
  }
}

class ProgramDecal extends StatelessWidget {
  final ColorTheme theme;
  ProgramDecal({this.theme});
  @override
  Widget build(BuildContext context) {
    ColorTheme t = theme == null ? RedTheme() : theme;
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: SizedBox(
        width: 160,
        child: Container(
          decoration: BoxDecoration(
            gradient: t.gradient,
            borderRadius: BorderRadius.circular(20)
          ),
        ),
      ),
    );
  }
}