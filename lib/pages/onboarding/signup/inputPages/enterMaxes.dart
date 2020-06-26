import 'package:flutter/material.dart';
import 'package:juma/models/lifting/exercise.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/pages/onboarding/signup/inputPages/createPR/createPR.dart';
import 'package:juma/theme/Colors.dart';
import 'package:juma/theme/liftIcons.dart';
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
  bool firstCreation;

  @override
  void initState() {
    widget.user.unitPreference ??= WeightUnit.pounds;
    firstCreation = true;
    super.initState();
  }

  void showDeleteInstruction(BuildContext context) async {
    var overlay = Overlay.of(context);
    var overlayEntry = OverlayEntry(
      builder: (context) {
        return Transform.translate(
          offset: Offset(0.0, (MediaQuery.of(context).size.height*.1)),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                Text(
                  'slide to remove',
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );

    await Future.delayed(Duration(seconds: 1));
    overlay.insert(overlayEntry);
    await Future.delayed(Duration(seconds: 3));
    overlayEntry.remove();
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
              stops: [0.0, 0.1, 0.9, 1.0]
            ).createShader(bounds);
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[

                // add new personal record button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: FlatButton(
                    onPressed: () async {
                      PersonalRecord newPR = await Navigator.of(context).push(MaterialPageRoute<PersonalRecord>(builder: (_) => CreatePR(unitPreference: widget.user.unitPreference,)));
                      if (newPR != null) {
                        var tl = widget.user.trackedLifts.lookup(TrackedLift(newPR.lift.descriptor));
                        if (tl == null) {
                          setState(() {
                            widget.user.addNewPR(newPR);
                          });
                        }
                        else {
                          widget.user.trackedLifts.remove(tl);
                          setState(() {
                            widget.user.addNewPR(newPR);
                          });
                        }

                        if (firstCreation && widget.user.trackedLifts.length <= 1) {
                          firstCreation = false;
                          showDeleteInstruction(context);
                        }
                      }
                    },
                    child: Icon(Icons.add, color: Colors.white,),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white)
                    ),
                  ),
                ),

                // list of items
                for (TrackedLift trackedLift in widget.user.trackedLifts) 
                  for (PersonalRecord pr in trackedLift.getPrForEachRep())
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Dismissible(
                        key: Key(pr.lift.descriptor.toString()),
                        onDismissed: (direction) {
                          setState(() {
                            var tl = widget.user.trackedLifts.lookup(TrackedLift(pr.lift.descriptor));
                            widget.user.trackedLifts.remove(tl);
                          });
                        },
                        direction: DismissDirection.endToStart,
                        background: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Icon(Icons.delete, color: Colors.red,),
                              ],
                            ),
                          ),
                        ),
                        child: LiftItemBar(lift: pr.lift, unit: widget.user.unitPreference,)
                      ),
                    ),
              ],
            ),
          ),
        ),

      ],
    );
  }
}

class LiftItemBar extends StatelessWidget {
  const LiftItemBar({
    Key key,
    @required this.lift,
    this.unit=WeightUnit.pounds
  }) : super(key: key);

  final MainLift lift;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    IconData liftIcon;
    ColorTheme liftTheme;

    switch (lift.type) {
      case MainLiftType.squat: {
        liftIcon = LiftIcons.squat;
        liftTheme = ColorTheme.getLiftTheme(LiftTheme.squat);
        break;
      }
      case MainLiftType.bench: {
        liftIcon = LiftIcons.bench;
        liftTheme = ColorTheme.getLiftTheme(LiftTheme.bench);
        break;
      }
      case MainLiftType.deadlift: {
        liftIcon = LiftIcons.deadlift;
        liftTheme = ColorTheme.getLiftTheme(LiftTheme.deadlift);
        break;
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Icon box
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: liftTheme.gradient
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      liftIcon,
                      color: Colors.white,
                    ),
                  ),
                ),

                SizedBox(width: 8.0,),

                //name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(lift.name.toUpperCase(), style: TextStyle( fontWeight: FontWeight.bold, fontSize: 15.0 ),),
                    Text(lift.descriptor.path.substring(lift.descriptor.path.indexOf('/')+2), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),),
                  ],
                ),
              ],
            ),

            Text(
              unit == WeightUnit.pounds ?
              '${lift.weight.pounds.round()} LB'
              :
              '${lift.weight.kilograms.round()} KG', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            )
          ],
        ),
      ),
    );
  }
}