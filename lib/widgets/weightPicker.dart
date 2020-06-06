import 'package:flutter/material.dart';
import 'package:juma/models/lifting/weight.dart';

class WeightPicker extends StatefulWidget {
  final WeightUnit unit;
  final Weight weight;
  WeightPicker(this.weight, {this.unit=WeightUnit.pounds});
  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  TextEditingController controller;
  FocusNode f;

  @override
  void initState() {
    controller = TextEditingController();
    f = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    f.unfocus();
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
            focusNode: f,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
              ),
            ),
            cursorColor: Colors.white,
            //autofocus: true,
            style: TextStyle(color: Colors.white),
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
            onChanged: (val) {
              setState(() {
                if (widget.unit == WeightUnit.kilograms) {
                  widget.weight.kilograms = double.parse(val);
                  //f.unfocus();
                  // TODO fix focusing for the createPR screen
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