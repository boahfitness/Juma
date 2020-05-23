import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/theme/Colors.dart';

class CreatePR extends StatefulWidget {
  @override
  _CreatePRState createState() => _CreatePRState();
}

class _CreatePRState extends State<CreatePR> {

  Squat squat = Squat();
  Bench bench = Bench();
  Deadlift deadlift = Deadlift();

  MainLift selectedLift;

  @override
  void initState() {
    selectedLift = squat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: JumaColors.lightGreyGradient
      ),
      child: Stack(
        children: <Widget>[

          Text(
            selectedLift.name[0].toUpperCase(), 
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              color: Colors.white,
              fontSize: 400
            ),
          ),

          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text('Choose a Lift', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LiftPicker(squat),
                    LiftPicker(bench),
                    LiftPicker(deadlift)
                  ],
                ),
              ),
            ),
            floatingActionButton: FlatButton(
              onPressed: () {},
              child: Text('NEXT', style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}

class LiftPicker extends StatefulWidget {
  final MainLift lift;
  LiftPicker(this.lift);
  @override
  _LiftPickerState createState() => _LiftPickerState();
}

class _LiftPickerState extends State<LiftPicker> {

  ColorTheme theme;

  @override
  void initState() {
    switch (widget.lift.name) {
      case 'Squat':
        theme = ColorTheme.getTheme(ThemeType.red);
        break;
      case 'Bench':
        theme = ColorTheme.getTheme(ThemeType.green);
        break;
      case 'Deadlift':
        theme = ColorTheme.getTheme(ThemeType.purple);
        break;
      default:
        theme = ColorTheme.getTheme(ThemeType.gold);
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 3,
            height: 100,
            decoration: BoxDecoration(
              gradient: theme.gradient
            ),
          ),
          Container(
            height: 100,
            width: 300,
            color: JumaColors.boahDarkGrey,
            child: Center(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: Text(widget.lift.name[0].toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 60),),
                  ),
                  Text(widget.lift.name.toUpperCase(), style: TextStyle(color: Colors.white),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}