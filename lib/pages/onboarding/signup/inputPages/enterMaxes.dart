import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/widgets/weightUnitPicker.dart';
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
      ],
    );
  }
}