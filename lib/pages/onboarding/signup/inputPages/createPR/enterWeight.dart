import 'package:flutter/material.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/lifting/weight.dart';
import 'package:juma/widgets/weightPicker.dart';

class EnterWeight extends StatefulWidget {
  final PersonalRecord pr;
  final WeightUnit unitPreference;
  EnterWeight(this.pr, {this.unitPreference = WeightUnit.pounds});
  @override
  _EnterWeightState createState() => _EnterWeightState();
}

class _EnterWeightState extends State<EnterWeight> {

  @override
  void initState() {
    //widget.pr.lift.weight = Weight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Text(widget.pr.lift.descriptor.path, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Text('Enter your One Rep Max', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
        ),
        WeightPicker(widget.pr.lift.weight, unit: widget.unitPreference,),
      ],
    );
  }
}