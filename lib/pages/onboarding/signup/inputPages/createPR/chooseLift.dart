import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/theme/Colors.dart';

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

  bool sEnabled, bEnabled, dEnabled;

  @override
  void initState() {
    widget.personalRecord.lift ??= squat;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    switch (widget.personalRecord.lift.name) {
      case 'Squat': {
        sEnabled = true; bEnabled = dEnabled = false;
      }
      break;
      case 'Bench': {
        bEnabled = true; sEnabled = dEnabled = false;
      }
      break;
      case 'Deadlift': {
        dEnabled = true; sEnabled = bEnabled = false;
      }
      break;
      default: {
        sEnabled = true; bEnabled = dEnabled = false;
      }
    }

    return Stack(
      children: <Widget>[

        ShaderMask(
          blendMode: BlendMode.dstOut,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.transparent, Colors.black],
            ).createShader(bounds);
          },
          child: Transform.translate(
            offset: Offset(0.0, -75),
            child: Text(
              widget.personalRecord.lift.name[0].toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                color: Colors.white,
                fontSize: 400,
                decoration: TextDecoration.none,
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
                LiftPicker(squat, enabled: sEnabled,
                  onTap: () { 
                    setState(() { 
                      widget.personalRecord.lift = squat;
                    }); 
                  },
                ),
                LiftPicker(bench, enabled: bEnabled,
                  onTap: () { 
                    setState(() { 
                      widget.personalRecord.lift = bench;
                    }); 
                  },
                ),
                LiftPicker(deadlift, enabled: dEnabled,
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
                      child: Text(widget.lift.name[0].toUpperCase(), style: TextStyle(color: widget.enabled ? Colors.white : Colors.grey[700], fontWeight: FontWeight.bold, fontSize: 60),),
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