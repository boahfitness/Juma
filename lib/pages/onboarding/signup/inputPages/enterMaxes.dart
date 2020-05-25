import 'package:flutter/material.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/pages/onboarding/signup/inputPages/createPR/createPR.dart';
import 'package:juma/widgets/auraPicker.dart';
import 'package:juma/models/lifting/weight.dart';

class EnterMaxes extends StatefulWidget {

  final User user;

  EnterMaxes(this.user);

  @override
  _EnterMaxesState createState() => _EnterMaxesState();
}

class _EnterMaxesState extends State<EnterMaxes> {

  bool kgEnabled, lbEnabled;

  @override
  void initState() {
    widget.user.unitPreference ??= WeightUnit.pounds;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Personal Records!\n" +
          "We'll track your PRs for you.\n" +
          "You can input your current ones if you know them.",
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            AuraPicker(text: 'KG', enabled: widget.user.unitPreference == WeightUnit.kilograms,
              onTap: () {
                setState(() {
                  widget.user.unitPreference = WeightUnit.kilograms;
                });
              },
            ),
            AuraPicker(text: 'LB', enabled: widget.user.unitPreference == WeightUnit.pounds,
              onTap: () {
                setState(() {
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

                // add new personal record button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: FlatButton(
                    onPressed: () async {
                      PersonalRecord newPR = await Navigator.of(context).push(MaterialPageRoute<PersonalRecord>(builder: (_) => CreatePR()));
                      widget.user.addNewPR(newPR);
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