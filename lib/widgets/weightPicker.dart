import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juma/models/lifting/weight.dart';
import 'package:juma/theme/Colors.dart';

class WeightPicker extends StatefulWidget {
  final WeightUnit unit;
  final Weight weight;
  final String Function(String) validator;
  WeightPicker(this.weight, {this.unit=WeightUnit.pounds, this.validator});
  @override
  _WeightPickerState createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  TextEditingController controller;
  FocusNode focusNode;
  OverlayEntry overlayEntry;

  @override
  void initState() {
    controller = TextEditingController();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus && Platform.isIOS) {
        showDoneButton(context, focusNode);
      }
      else {
        removeDoneButton();
      }
    });
    super.initState();
  }

  void showDoneButton(BuildContext context, FocusNode focusNode) {
    var overlay = Overlay.of(context);
    if (overlayEntry != null) return;

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0.0,
        left: 0.0,
        child: KeyBoardDoneButton(focusNode),
      );
    });

    overlay.insert(overlayEntry);
  }

  void removeDoneButton() {
    if (overlayEntry != null) {
      overlayEntry.remove();
      overlayEntry = null;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: TextFormField(
            validator: widget.validator,
            focusNode: focusNode,
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

class KeyBoardDoneButton extends StatelessWidget {
  final FocusNode f;
  KeyBoardDoneButton(this.f);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: JumaColors.boahLightGrey,
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: CupertinoButton(
            padding: EdgeInsets.only(right: 24.0, top: 8.0, bottom: 8.0),
            onPressed: () {
              f.unfocus();
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}