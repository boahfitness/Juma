import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/widgets/auraPicker.dart';

class SquatCustomizer extends StatefulWidget {
  final PersonalRecord pr;
  SquatCustomizer(this.pr);
  @override
  _SquatCustomizerState createState() => _SquatCustomizerState(pr.lift);
}

class _SquatCustomizerState extends State<SquatCustomizer> {
  final Squat lift;
  final ColorTheme theme = LiftThemes.squat;
  _SquatCustomizerState(this.lift);
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
              child: Text('SQUAT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
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
                  text: 'HIGHBAR',
                  fontSize: 12,
                  enabled: lift.variation == SquatVariation.highBar,
                  onTap: () {
                    setState(() {
                      lift.variation = SquatVariation.highBar;
                    });
                  },
                ),
                AuraPicker(
                  theme: theme,
                  text: 'LOW BAR',
                  fontSize: 12,
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
                AuraPicker(
                  text: 'RAW',
                  fontSize: 12,
                  enabled: lift.equipment == SquatEquipment.raw,
                  onTap: () {
                    setState(() {
                      lift.equipment = SquatEquipment.raw;
                    });
                  },
                ),
                AuraPicker(
                  theme: theme,
                  text: 'EQUIPPED',
                  fontSize: 12,
                  enabled: lift.equipment != SquatEquipment.raw,
                  onTap: () {
                    setState(() {
                      if (lift.equipment == SquatEquipment.raw)
                        lift.equipment = SquatEquipment.suit;
                    });
                  },
                )
              ],
            ),
            AnimatedPadding(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(vertical: lift.equipment != SquatEquipment.raw ? 10.0 : 0.0),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: lift.equipment == SquatEquipment.raw ? 0 : 100,
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
                    enabled: lift.equipment == SquatEquipment.suit,
                    onTap: () {
                      setState(() {
                        lift.equipment = SquatEquipment.suit;
                      });
                    },
                  ),
                  AuraPicker(
                    theme: theme,
                    text: 'BREIFS',
                    fontSize: 12,
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
            AuraPicker(
              theme: theme,
              text: 'WRAPS',
              fontSize: 12,
              enabled: lift.kneeEquipment == KneeEquipment.wraps,
              onTap: () {
                setState(() {
                  lift.kneeEquipment = lift.kneeEquipment == KneeEquipment.wraps ? KneeEquipment.none : KneeEquipment.wraps;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}