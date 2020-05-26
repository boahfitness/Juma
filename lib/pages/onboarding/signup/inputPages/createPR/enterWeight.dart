import 'package:flutter/material.dart';
import 'package:juma/models/lifting/personalRecords.dart';
import 'package:juma/models/lifting/weight.dart';

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
        WeightPicker(widget.pr.lift.weight, unit: widget.unitPreference,),
      ],
    );
  }
}

class WeightPicker extends StatefulWidget {
  final WeightUnit unit;
  final Weight weight;
  WeightPicker(this.weight, {this.unit=WeightUnit.pounds});
  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.unit == WeightUnit.pounds ? widget.weight.pounds.toString() : widget.weight.kilograms.toString());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: TextField(
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
            ),
            style: TextStyle(color: Colors.white),
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
            onChanged: (val) {
              setState(() {
                if (widget.unit == WeightUnit.kilograms) {
                  widget.weight.kilograms = double.parse(val);
                }
                else {
                  widget.weight.pounds = double.parse(val);
                }
              });
            },
          ),
        ),
        Text(widget.unit == WeightUnit.pounds ? 'LB' : 'KG', style: TextStyle(color: Colors.white),),
      ],
    );
  }
}