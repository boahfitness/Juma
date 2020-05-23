import 'package:flutter/material.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/widgets/weightUnitPicker.dart';
import 'package:juma/models/lifting/weight.dart';
import 'package:juma/models/lifting/exercise.dart';

class EnterMaxes extends StatefulWidget {

  final User user;

  EnterMaxes(this.user);

  @override
  _EnterMaxesState createState() => _EnterMaxesState();
}

class _EnterMaxesState extends State<EnterMaxes> {

  bool kgEnabled, lbEnabled;
  List<MainLift> allMainLifts;

  @override
  void initState() {
    allMainLifts = List();
    allMainLifts.addAll(Squat.getAllPossibleVariations());
    allMainLifts.addAll(Bench.getAllPossibleVariations());
    allMainLifts.addAll(Deadlift.getAllPossibleVariations());
    if (widget.user.unitPreference != null) {
      lbEnabled = widget.user.unitPreference == WeightUnit.pounds ? true : false;
      kgEnabled = !lbEnabled;
    }
    else {
      lbEnabled = true;
      kgEnabled = false;
      widget.user.unitPreference = WeightUnit.pounds;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "PRs!\n" +
          "We'll track your PRs for you.\n" +
          "You can input your current ones if you know them.",
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            WeightUnitPicker(width: 100, unit: WeightUnit.kilograms, enabled: kgEnabled,
              onTap: () {
                setState(() {
                  kgEnabled = true;
                  lbEnabled = false;
                  widget.user.unitPreference = WeightUnit.kilograms;
                });
              },
            ),
            WeightUnitPicker(width: 100, unit: WeightUnit.pounds, enabled: lbEnabled,
              onTap: () {
                setState(() {
                  lbEnabled = true;
                  kgEnabled = false;
                  widget.user.unitPreference = WeightUnit.pounds;
                });
              },
            )
          ],
        ),

        ShaderMask(
          blendMode: BlendMode.dstOut,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.black, Colors.transparent, Colors.transparent, Colors.black],
              stops: [0.0, 0.1, 0.75, 1.0]
            ).createShader(bounds);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                for (TrackedLift lift in widget.user.trackedLifts) FlatButton(
                  onPressed: () {},
                  child: Text(lift.liftDescriptor.path),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.white),
                  ),
                ),

                // add new lift button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: FlatButton(
                    onPressed: () async {
                      await Navigator.of(context).pushNamed('/create-pr');
                    },
                    child: Icon(Icons.add, color: Colors.white,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

      ],
    );
  }
}