import 'package:flutter/material.dart';
import 'package:juma/models/users/user.dart';
import 'package:juma/theme/Colors.dart';

class PickLifts extends StatefulWidget {
  final User user;
  PickLifts(this.user);
  @override
  _PickLiftsState createState() => _PickLiftsState();
}

class _PickLiftsState extends State<PickLifts> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Keep up with your Progress!\nWhich lifts would you like us to track?", textAlign: TextAlign.left,),
          Text("You can change these later.", textAlign: TextAlign.left, style: TextStyle(fontSize: 12, color: Colors.grey),),
          
        ],
      ),
    );
  }
}

class DropDownController extends StatefulWidget {
  @override
  _DropDownControllerState createState() => _DropDownControllerState();
}

class _DropDownControllerState extends State<DropDownController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class DropDownLevel {
  List<Widget> items;
}

class DropdownPicker extends StatefulWidget {
  final String text;
  final List<Widget> children;

  DropdownPicker({ 
    @required 
    this.text,
    @required
    this.children
  });

  @override
  _DropdownPickerState createState() => _DropdownPickerState();
}

class _DropdownPickerState extends State<DropdownPicker> {

  Color color = Colors.white;
  IconData icon = Icons.keyboard_arrow_down;
  bool dropped = false;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      highlightColor: JumaColors.boahOrange,
      height: 30.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: color)
        ),
        child: SizedBox(
          width: widget.text.length * 6 + 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(widget.text, style: TextStyle(color: color),),
              Icon(icon, color: color,) 
            ]
          ),
        ),
        onPressed: () {
          setState(() {
            color = color == Colors.white ? JumaColors.boahOrange : Colors.white;
            icon = icon == Icons.keyboard_arrow_down ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down;
            dropped = !dropped;
          });
        },
      ),
    );
  }
}


class Picker extends StatefulWidget {
  final String text;

  Picker({
    @required
    this.text,
  });

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      highlightColor: JumaColors.boahOrange,
      height: 30.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: color)
        ),
        child: Text(widget.text, style: TextStyle(color: color),),
        onPressed: () {
          setState(() {
            color = color == Colors.white ? JumaColors.boahOrange : Colors.white;
          });
        },
      ),
    );
  }
}