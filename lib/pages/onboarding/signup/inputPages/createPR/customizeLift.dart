import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/theme/Colors.dart';

class CustomizeLift extends StatefulWidget {
  final PersonalRecord personalRecord;
  CustomizeLift(this.personalRecord);
  @override
  _CustomizeLiftState createState() => _CustomizeLiftState();
}

class _CustomizeLiftState extends State<CustomizeLift> {
  @override
  Widget build(BuildContext context) {
    switch (widget.personalRecord.lift.type) {
      case MainLiftType.squat: return SquatCustomizer(widget.personalRecord);
      case MainLiftType.deadlift: return DeadCustomizer(widget.personalRecord);
      case MainLiftType.bench: return BenchCustomizer(widget.personalRecord);
      default: throw Exception('invalid MainLiftType in personalRecord');
    }
  }
}

class Picker extends StatefulWidget {
  final String text;
  final bool enabled;
  final Function() onTap;
  Picker(this.text, {this.enabled=false, @required this.onTap});
  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        height: 100,
        width: 100,
        color: widget.enabled ? Colors.black : Colors.black45,
        child: Center(
          child: Text(widget.text, style: TextStyle(color: widget.enabled ? Colors.white : Colors.grey[700],),),
        ),
      ),
    );
  }
}

class SquatCustomizer extends StatefulWidget {
  final PersonalRecord pr;
  SquatCustomizer(this.pr);
  @override
  _SquatCustomizerState createState() => _SquatCustomizerState(pr.lift);
}

class _SquatCustomizerState extends State<SquatCustomizer> {
  final Squat lift;
  _SquatCustomizerState(this.lift);
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text('Variations', style: TextStyle(color: Colors.white),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Picker(
                'HIGHBAR',
                enabled: lift.variation == SquatVariation.highBar,
                onTap: () {
                  setState(() {
                    lift.variation = SquatVariation.highBar;
                  });
                },
              ),
              Picker(
                'LOW BAR',
                enabled: lift.variation == SquatVariation.lowBar,
                onTap: () {
                  setState(() {
                    lift.variation = SquatVariation.lowBar;
                  });
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text('Equipment', style: TextStyle(color: Colors.white),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Picker(
                'RAW',
                enabled: lift.equipment == SquatEquipment.raw,
                onTap: () {
                  setState(() {
                    lift.equipment = SquatEquipment.raw;
                  });
                },
              ),
              Picker(
                'EQUIPPED',
                enabled: lift.equipment != SquatEquipment.raw,
                onTap: () {
                  setState(() {
                    lift.equipment = SquatEquipment.suit;
                  });
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: lift.equipment == SquatEquipment.raw ? 0 : 2.0,
              width: 300,
              color: Colors.red,
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: lift.equipment == SquatEquipment.raw ? 0 : 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Picker(
                  'SUIT',
                  enabled: lift.equipment == SquatEquipment.suit,
                  onTap: () {
                    setState(() {
                      lift.equipment = SquatEquipment.suit;
                    });
                  },
                ),
                Picker(
                  'BREIFS',
                  enabled: lift.equipment == SquatEquipment.breifs,
                  onTap: () {
                    setState(() {
                      lift.equipment = SquatEquipment.breifs;
                    });
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Wraps', style: TextStyle(color: Colors.white),),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Transform.scale(
                    scale: 2.0,
                    child: Switch(
                      activeColor: Colors.red,
                      value: lift.kneeEquipment == KneeEquipment.wraps,
                      onChanged: (wraps) {
                        setState(() {
                          lift.kneeEquipment = wraps ? KneeEquipment.wraps : KneeEquipment.none;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BenchCustomizer extends StatefulWidget {
  final PersonalRecord pr;
  BenchCustomizer(this.pr);
  @override
  _BenchCustomizerState createState() => _BenchCustomizerState();
}

class _BenchCustomizerState extends State<BenchCustomizer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Bench'),
    );
  }
}

class DeadCustomizer extends StatefulWidget {
  final PersonalRecord pr;
  DeadCustomizer(this.pr);
  @override
  _DeadCustomizerState createState() => _DeadCustomizerState();
}

class _DeadCustomizerState extends State<DeadCustomizer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Deadlift'),
    );
  }
}