import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/widgets/auraPicker.dart';

class BenchCustomizer extends StatefulWidget {
  final PersonalRecord pr;
  BenchCustomizer(this.pr);
  @override
  _BenchCustomizerState createState() => _BenchCustomizerState(pr.lift);
}

class _BenchCustomizerState extends State<BenchCustomizer> {
  final Bench lift;
  _BenchCustomizerState(this.lift);
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
              child: Text('BENCH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
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
                  enabled: lift.equipment == BenchEquipment.raw,
                  onTap: () {
                    setState(() {
                      lift.equipment = BenchEquipment.raw;
                    });
                  },
                ),
                AuraPicker(
                  text: 'EQUIPPED',
                  fontSize: 12,
                  enabled: lift.equipment != BenchEquipment.raw,
                  onTap: () {
                    setState(() {
                      if (lift.equipment == BenchEquipment.raw)
                        lift.equipment = BenchEquipment.shirt;
                    });
                  },
                )
              ],
            ),
            AnimatedPadding(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(vertical: lift.equipment != BenchEquipment.raw ? 10.0 : 0.0),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              height: lift.equipment == BenchEquipment.raw ? 0 : 100,
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
                    text: 'SHIRT',
                    fontSize: 12,
                    enabled: lift.equipment == BenchEquipment.shirt,
                    onTap: () {
                      setState(() {
                        lift.equipment = BenchEquipment.shirt;
                      });
                    },
                  ),
                  AuraPicker(
                    text: 'SLINGSHOT',
                    fontSize: 12,
                    enabled: lift.equipment == BenchEquipment.slingshot,
                    onTap: () {
                      setState(() {
                        lift.equipment = BenchEquipment.slingshot;
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}