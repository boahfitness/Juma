import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/program.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/services/authService.dart';
import 'package:juma/services/googleSheetsService.dart';
import 'package:juma/services/programService.dart';
import 'package:juma/theme/Colors.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProgramService programService = ProgramService();
  ProgramHistory currentProgram = ProgramHistory();
  List<ProgramDescriptor> userLibrary= [];

  Future<void> getProgramData(User user) async {
    currentProgram = await programService.getProgramHistory(user.currentProgramId);
    userLibrary = await programService.getProgramTemplates(user.programCatalog);
    if (userLibrary != null) userLibrary = userLibrary.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return user != null ? 
    FutureBuilder(
      future: getProgramData(user),
      builder: (context, snapshot) {
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
                currentProgram != null ? CurrentProgramDisplay(currentProgram: currentProgram) 
                : Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Create a New Program"),
                      SizedBox(height: 15,),
                      FlatButton(
                        onPressed: () async {
                          var account = await AuthService().currentUser;
                          await GoogleSheetsService().createSpreadsheet(account.email);
                        },
                        color: RedTheme().solid,
                        child: Icon(Icons.add),
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(10),
                      )
                    ],
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
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: userLibrary != null ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: userLibrary.length,
                      itemBuilder: (context, index) {
                        return ProgramDecal(userLibrary[index]);
                      }
                    ) : Container(),
                  ),
                ),
              ],
            ),
          ),

          drawer: Drawer(),
        );
      },
    ) : Container();
  }
}

class CurrentProgramDisplay extends StatelessWidget {
  const CurrentProgramDisplay({
    Key key,
    @required this.currentProgram,
  }) : super(key: key);

  final ProgramHistory currentProgram;

  @override
  Widget build(BuildContext context) {
    Day nextDay = currentProgram != null ? currentProgram.nextDay : null;
    Exercise nextEx = nextDay != null ? nextDay.firstExercise : null;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/current-program', arguments: currentProgram);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.4,
        decoration: BoxDecoration(
          gradient: currentProgram.theme != null ? currentProgram.theme.gradient : JumaColors.lightGreyGradient,
          borderRadius: BorderRadius.circular(40)
        ),
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(currentProgram.title ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              Text(currentProgram.description ?? '', textAlign: TextAlign.left,),
              Text(currentProgram.author != null ? currentProgram.author.displayName ?? '' : '', textAlign: TextAlign.left,),
              Text(nextEx != null ? nextEx.name : '')
            ],
          )
        ),
      ),
    );
  }
}

class ProgramDecal extends StatelessWidget {
  final ProgramDescriptor program;
  ProgramDecal(this.program);
  @override
  Widget build(BuildContext context) {
    ColorTheme theme = program != null ? program.theme ?? BlackTheme() : BlackTheme();
    return program != null ? Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: SizedBox(
        width: 160,
        child: Container(
          decoration: BoxDecoration(
            gradient: theme.gradient,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(program.title ?? '', style: TextStyle(fontWeight: FontWeight.bold, color: theme.textColor)),
                Text(program.author != null ? program.author.displayName ?? '' : '', style: TextStyle(color: theme.textColor),)
              ],
            ),
          ),
        ),
      ),
    ) : Container(width: 0, height: 0,);
  }
}