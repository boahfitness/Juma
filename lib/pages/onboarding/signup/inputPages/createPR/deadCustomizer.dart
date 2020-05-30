import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/widgets/auraPicker.dart';

class DeadCustomizer extends StatefulWidget {
  final PersonalRecord pr;
  DeadCustomizer(this.pr);
  @override
  _DeadCustomizerState createState() => _DeadCustomizerState(pr.lift);
}

class _DeadCustomizerState extends State<DeadCustomizer> {
  final Deadlift lift;
  final ColorTheme theme = ColorTheme.getLiftTheme(LiftTheme.deadlift);
  _DeadCustomizerState(this.lift);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Transform.translate(
        offset: Offset(0.0, -50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text('DEADLIFT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Text('Variations', style: TextStyle(color: Colors.white),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AuraPicker(
                  theme: theme,
                  text: 'CONV',
                  fontSize: 12,
                  enabled: lift.variation == DeadliftVariation.conv,
                  onTap: () {
                    setState(() {
                      lift.variation = DeadliftVariation.conv;
                    });
                  },
                ),
                AuraPicker(
                  theme: theme,
                  text: 'SUMO',
                  fontSize: 12,
                  enabled: lift.variation == DeadliftVariation.sumo,
                  onTap: () {
                    setState(() {
                      lift.variation = DeadliftVariation.sumo;
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
                AuraPicker(
                  theme: theme,
                  text: 'RAW',
                  fontSize: 12,
                  enabled: lift.equipment == DeadliftEquipment.raw,
                  onTap: () {
                    setState(() {
                      lift.equipment = DeadliftEquipment.raw;
                    });
                  },
                ),
                AuraPicker(
                  theme: theme,
                  text: 'EQUIPPED',
                  fontSize: 12,
                  enabled: lift.equipment != DeadliftEquipment.raw,
                  onTap: () {
                    setState(() {
                      if (lift.equipment == DeadliftEquipment.raw)
                        lift.equipment = DeadliftEquipment.suit;
                    });
                  },
                )
              ],
            ),
            AnimatedPadding(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(vertical: lift.equipment != DeadliftEquipment.raw ? 10.0 : 0.0),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: lift.equipment == DeadliftEquipment.raw ? 0 : 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black45],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AuraPicker(
                    theme: theme,
                    text: 'SUIT',
                    fontSize: 12,
                    enabled: lift.equipment == DeadliftEquipment.suit,
                    onTap: () {
                      setState(() {
                        lift.equipment = DeadliftEquipment.suit;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}