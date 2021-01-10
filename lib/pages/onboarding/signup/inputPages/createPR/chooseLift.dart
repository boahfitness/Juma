import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/theme/liftIcons.dart';

class ChooseLift extends StatefulWidget {
  final PersonalRecord personalRecord;
  ChooseLift(this.personalRecord);
  @override 
  _ChooseLiftState createState() => _ChooseLiftState();
}

class _ChooseLiftState extends State<ChooseLift> {

  Squat squat = Squat();
  Bench bench = Bench();
  Deadlift deadlift = Deadlift();

  IconData icon;
  Color iconColor;

  @override
  void initState() {
    widget.personalRecord.lift ??= squat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    switch (widget.personalRecord.lift.type) {
      case MainLiftType.squat:
        iconColor = LiftThemes.squat.solid;
        icon = LiftIcons.squat;
        break;
      case MainLiftType.bench:
        iconColor = LiftThemes.bench.solid;
        icon = LiftIcons.bench;
        break;
      case MainLiftType.deadlift:
        iconColor = LiftThemes.deadlift.solid;
        icon = LiftIcons.deadlift;
        break;
      default:
        iconColor = ColorThemes.gold.solid;
        icon = LiftIcons.deadlift;
        break;
    }

    return Stack(
      children: <Widget>[
        Opacity(
          opacity: .3,
          child: ShaderMask(
            blendMode: BlendMode.dstOut,
            shaderCallback: (bounds) {
              return LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.transparent, Colors.black],
              ).createShader(bounds);
            },
            child: Transform.translate(
              offset: Offset(-50.0, 0.0),
              child: Icon(
                icon,
                size: 350.0,
                color: iconColor,
              ),
            ),
          ),
        ),

        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LiftPicker(squat, enabled: widget.personalRecord.lift.type == MainLiftType.squat,
                  onTap: () { 
                    setState(() { 
                      widget.personalRecord.lift = squat;
                    }); 
                  },
                ),
                LiftPicker(bench, enabled: widget.personalRecord.lift.type == MainLiftType.bench,
                  onTap: () { 
                    setState(() { 
                      widget.personalRecord.lift = bench;
                    }); 
                  },
                ),
                LiftPicker(deadlift, enabled: widget.personalRecord.lift.type == MainLiftType.deadlift,
                  onTap: () { 
                    setState(() { 
                      widget.personalRecord.lift = deadlift;
                    }); 
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LiftPicker extends StatefulWidget {
  final MainLift lift;
  final bool enabled;
  final void Function() onTap;
  LiftPicker(this.lift, {this.enabled=false, this.onTap});
  @override
  _LiftPickerState createState() => _LiftPickerState();
}

class _LiftPickerState extends State<LiftPicker> {

  ColorTheme theme;
  IconData icon;

  @override
  void initState() {
    switch (widget.lift.type) {
      case MainLiftType.squat:
        theme = LiftThemes.squat;
        icon = LiftIcons.squat;
        break;
      case MainLiftType.bench:
        theme = LiftThemes.bench;
        icon = LiftIcons.bench;
        break;
      case MainLiftType.deadlift:
        theme = LiftThemes.deadlift;
        icon = LiftIcons.deadlift;
        break;
      default:
        theme = ColorThemes.gold;
        icon = LiftIcons.deadlift;
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
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            width: 3,
            height: 100,
            decoration: BoxDecoration(
              gradient: widget.enabled ? theme.gradient
              : LinearGradient(
                  colors: [Colors.grey[700], Colors.grey]
              )
            ),
          ),
          GestureDetector(
            onTap: widget.onTap,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: 100,
              width: 300,
              decoration: BoxDecoration(
                color: widget.enabled ? JumaColors.boahDarkGrey : Colors.black,
              ),
              child: Center(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 20),
                      //child: Text(widget.lift.name[0].toUpperCase(), style: TextStyle(color: widget.enabled ? Colors.white : Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 60),),
                      child: Icon(icon, color: widget.enabled ? Colors.white : Colors.grey[700], size: 60),
                    ),
                    Text(widget.lift.name.toUpperCase(), style: TextStyle(color: widget.enabled ? Colors.white : Colors.grey[700]),)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}